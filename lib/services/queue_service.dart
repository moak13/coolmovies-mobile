import 'dart:collection';

import 'package:logger/logger.dart';

typedef QueueOperation<T> = Future<T> Function();

class QueueService {
  final Queue<QueueOperation> _queue = Queue<QueueOperation>();
  final Logger _logger = Logger();

  void addToQueue(QueueOperation operation) {
    _queue.add(operation);
  }

  Future<void> processQueue() async {
    while (_queue.isNotEmpty) {
      final operation = _queue.removeFirst();
      try {
        await operation();
      } catch (e, s) {
        _logger.e(
          'processing queue operation failed',
          error: e,
          stackTrace: s,
        );
      }
    }
  }
}
