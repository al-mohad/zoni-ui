import 'package:flutter_test/flutter_test.dart';
import 'package:zoni_ui/zoni_ui.dart';

void main() {
  group('ZoniLogger', () {
    setUp(() {
      // Reset logger to default state before each test
      ZoniLogger.initialize(
        isEnabled: true,
        allowedLevels: ZoniLogLevel.values.toSet(),
        prefix: 'Zoni',
      );
    });

    test('should be enabled by default in debug mode', () {
      expect(ZoniLogger.isEnabled, isTrue);
    });

    test('should allow all log levels by default', () {
      expect(ZoniLogger.allowedLevels, equals(ZoniLogLevel.values.toSet()));
    });

    test('should be configurable', () {
      ZoniLogger.initialize(
        isEnabled: false,
        allowedLevels: {ZoniLogLevel.error, ZoniLogLevel.critical},
        prefix: 'TestApp',
      );

      expect(ZoniLogger.isEnabled, isFalse);
      expect(ZoniLogger.allowedLevels, equals({ZoniLogLevel.error, ZoniLogLevel.critical}));
    });

    test('should enable/disable logging at runtime', () {
      ZoniLogger.setEnabled(false);
      expect(ZoniLogger.isEnabled, isFalse);

      ZoniLogger.setEnabled(true);
      expect(ZoniLogger.isEnabled, isTrue);
    });

    test('should set allowed log levels at runtime', () {
      final Set<ZoniLogLevel> newLevels = {ZoniLogLevel.warning, ZoniLogLevel.error};
      ZoniLogger.setAllowedLevels(newLevels);
      expect(ZoniLogger.allowedLevels, equals(newLevels));
    });

    test('should have all log level methods', () {
      // These should not throw exceptions
      expect(() => ZoniLogger.debug('Debug message'), returnsNormally);
      expect(() => ZoniLogger.info('Info message'), returnsNormally);
      expect(() => ZoniLogger.success('Success message'), returnsNormally);
      expect(() => ZoniLogger.warning('Warning message'), returnsNormally);
      expect(() => ZoniLogger.error('Error message'), returnsNormally);
      expect(() => ZoniLogger.critical('Critical message'), returnsNormally);
    });

    test('should handle metadata', () {
      final Map<String, dynamic> metadata = {'userId': 123, 'action': 'login'};
      
      // These should not throw exceptions
      expect(() => ZoniLogger.info('User action', metadata: metadata), returnsNormally);
      expect(() => ZoniLogger.error('Error occurred', metadata: metadata), returnsNormally);
    });

    test('should have quick logging methods', () {
      // These should not throw exceptions
      expect(() => ZoniLogger.pp('Quick print'), returnsNormally);
      expect(() => ZoniLogger.ll('Quick log'), returnsNormally);
    });

    test('should handle generic log method', () {
      // These should not throw exceptions
      expect(() => ZoniLogger.log(ZoniLogLevel.info, 'Generic log'), returnsNormally);
      expect(() => ZoniLogger.log(ZoniLogLevel.error, 'Generic error', metadata: {'test': true}), returnsNormally);
    });
  });

  group('ZoniUI Logger Integration', () {
    test('should provide access to all logger methods through ZoniUI', () {
      // These should not throw exceptions
      expect(() => ZoniUI.logDebug('Debug via ZoniUI'), returnsNormally);
      expect(() => ZoniUI.logInfo('Info via ZoniUI'), returnsNormally);
      expect(() => ZoniUI.logSuccess('Success via ZoniUI'), returnsNormally);
      expect(() => ZoniUI.logWarning('Warning via ZoniUI'), returnsNormally);
      expect(() => ZoniUI.logError('Error via ZoniUI'), returnsNormally);
      expect(() => ZoniUI.logCritical('Critical via ZoniUI'), returnsNormally);
    });

    test('should provide access to quick logging methods through ZoniUI', () {
      // These should not throw exceptions
      expect(() => ZoniUI.pp('Quick print via ZoniUI'), returnsNormally);
      expect(() => ZoniUI.ll('Quick log via ZoniUI'), returnsNormally);
    });

    test('should provide access to generic log method through ZoniUI', () {
      // These should not throw exceptions
      expect(() => ZoniUI.log(ZoniLogLevel.info, 'Generic log via ZoniUI'), returnsNormally);
    });

    test('should allow logger initialization through ZoniUI', () {
      // This should not throw an exception
      expect(() => ZoniUI.initializeLogger(
        isEnabled: true,
        allowedLevels: {ZoniLogLevel.error},
        prefix: 'TestZoni',
      ), returnsNormally);
    });

    test('should handle metadata through ZoniUI', () {
      final Map<String, dynamic> metadata = {'component': 'ZoniButton', 'state': 'pressed'};
      
      // These should not throw exceptions
      expect(() => ZoniUI.logInfo('Component interaction', metadata: metadata), returnsNormally);
      expect(() => ZoniUI.logError('Component error', metadata: metadata), returnsNormally);
    });
  });

  group('ZoniLogLevel', () {
    test('should have all expected log levels', () {
      expect(ZoniLogLevel.values, contains(ZoniLogLevel.debug));
      expect(ZoniLogLevel.values, contains(ZoniLogLevel.info));
      expect(ZoniLogLevel.values, contains(ZoniLogLevel.success));
      expect(ZoniLogLevel.values, contains(ZoniLogLevel.warning));
      expect(ZoniLogLevel.values, contains(ZoniLogLevel.error));
      expect(ZoniLogLevel.values, contains(ZoniLogLevel.critical));
    });

    test('should have correct number of log levels', () {
      expect(ZoniLogLevel.values.length, equals(6));
    });
  });
}
