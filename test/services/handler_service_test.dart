import 'package:coolmovies/core/locator.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('HandlerServiceTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
