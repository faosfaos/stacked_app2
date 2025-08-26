import 'package:flutter_test/flutter_test.dart';
import 'package:stacked_app2/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('SqlDatabaseServiceTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
