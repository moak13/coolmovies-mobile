import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:coolmovies/core/locator.dart';
import 'package:coolmovies/services/services.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class HandlerService with ChangeNotifier {
  final ConnectivityService _connectivityService =
      locator.get<ConnectivityService>();
  final QueueService _queueService = locator.get<QueueService>();
  final StorageService _storageService = locator.get<StorageService>();

  final Logger _logger = Logger();

  late StreamSubscription<ConnectivityResult> _subscription;

  HandlerService() {
    _subscription =
        _connectivityService.connectivityStream.listen(_connectionChange);
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  Future<void> _connectionChange(ConnectivityResult result) async {
    if (result != ConnectivityResult.none) {
      try {
        await _queueService.processQueue();
      } catch (e, s) {
        _logger.e(
          'Error processing queue on connectivity change',
          error: e,
          stackTrace: s,
        );
      }
    }
  }

  Future<T?> makeNetworkCall<T>(
    Future<T> Function() networkCall, {
    required String storageKey,
    T Function(dynamic)? fromJson,
  }) async {
    ConnectivityResult result = await _connectivityService.connectivityStatus;
    if (result == ConnectivityResult.none) {
      _queueService.addToQueue(
        () async {
          try {
            T response = await networkCall();
            await _storageService.saveResponse<T>(
              storageKey,
              response,
            );
            return response;
          } catch (e, s) {
            _logger.e(
              'Error executing queued network call',
              error: e,
              stackTrace: s,
            );
          }
        },
      );
      var storedResponse = await _storageService.getResponse<T>(
        storageKey,
        fromJson: fromJson,
      );
      if (storedResponse != null) {
        return storedResponse;
      }
      return null;
    }
    try {
      T response = await networkCall();
      await _storageService.saveResponse<T>(
        storageKey,
        response,
      );
      return response;
    } catch (e, s) {
      _logger.e(
        'Error executing network call',
        error: e,
        stackTrace: s,
      );
      rethrow;
    }
  }
}
