import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class ConnectivityService with ChangeNotifier {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _subscription;
  ConnectivityResult _currentResult = ConnectivityResult.none;
  final Logger _logger = Logger();

  ConnectivityService() {
    _subscription =
        _connectivity.onConnectivityChanged.listen(_connectionChange);
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      _currentResult = await _connectivity.checkConnectivity();
      notifyListeners();
    } catch (e, s) {
      _logger.e(
        'Error checking initial connectivity',
        error: e,
        stackTrace: s,
      );
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  void _connectionChange(ConnectivityResult result) {
    try {
      _currentResult = result;
      notifyListeners();
    } catch (e, s) {
      _logger.e(
        'Error handling connectivity change',
        error: e,
        stackTrace: s,
      );
    }
  }

  Future<ConnectivityResult> get connectivityStatus async {
    return _currentResult;
  }

  Stream<ConnectivityResult> get connectivityStream {
    return _connectivity.onConnectivityChanged;
  }
}
