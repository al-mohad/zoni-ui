import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

/// Log levels for filtering and categorizing log messages.
enum ZoniLogLevel {
  /// Debug information for development
  debug,

  /// General information
  info,

  /// Success messages
  success,

  /// Warning messages that don't break functionality
  warning,

  /// Error messages for recoverable errors
  error,

  /// Critical errors that may cause app crashes
  critical,
}

/// A comprehensive logger for the Zoni design system.
///
/// Provides colored console output, filtering by log levels, and metadata support.
/// Automatically enabled in debug mode and can be customized for different environments.
///
/// Example usage:
/// ```dart
/// ZoniLogger.info('User logged in successfully');
/// ZoniLogger.error('Failed to load data', metadata: {'userId': 123});
/// ZoniLogger.debug('Component rendered', metadata: {'widget': 'ZoniButton'});
/// ```
class ZoniLogger {
  static bool _isEnabled = kDebugMode;
  static Set<ZoniLogLevel> _allowedLevels = ZoniLogLevel.values.toSet();
  static String _prefix = 'Zoni';

  // ANSI color codes for console output
  static const String _reset = '\x1B[0m';
  static const String _blue = '\x1B[34m'; // Info
  static const String _green = '\x1B[32m'; // Success
  static const String _yellow = '\x1B[33m'; // Warning
  static const String _red = '\x1B[31m'; // Error
  static const String _magenta = '\x1B[35m'; // Critical
  static const String _cyan = '\x1B[36m'; // Debug

  /// Initializes the logger with custom settings.
  ///
  /// [isEnabled] - Whether logging is enabled (default: kDebugMode)
  /// [allowedLevels] - Set of log levels to display (default: all levels)
  /// [prefix] - Custom prefix for log messages (default: 'Zoni')
  static void initialize({
    bool? isEnabled,
    Set<ZoniLogLevel>? allowedLevels,
    String? prefix,
  }) {
    if (isEnabled != null) _isEnabled = isEnabled;
    if (allowedLevels != null) _allowedLevels = allowedLevels;
    if (prefix != null) _prefix = prefix;
  }

  /// Logs a debug message.
  ///
  /// Use for development information that helps with debugging.
  static void debug(String message, {Object? metadata}) {
    _log(ZoniLogLevel.debug, message, metadata);
  }

  /// Logs an info message.
  ///
  /// Use for general information about app state or user actions.
  static void info(String message, {Object? metadata}) {
    _log(ZoniLogLevel.info, message, metadata);
  }

  /// Logs a success message.
  ///
  /// Use for successful operations or positive user feedback.
  static void success(String message, {Object? metadata}) {
    _log(ZoniLogLevel.success, message, metadata);
  }

  /// Logs a warning message.
  ///
  /// Use for potentially problematic situations that don't break functionality.
  static void warning(String message, {Object? metadata}) {
    _log(ZoniLogLevel.warning, message, metadata);
  }

  /// Logs an error message.
  ///
  /// Use for recoverable errors that affect functionality.
  static void error(String message, {Object? metadata}) {
    _log(ZoniLogLevel.error, message, metadata);
  }

  /// Logs a critical error message.
  ///
  /// Use for severe errors that may cause app crashes or data loss.
  static void critical(String message, {Object? metadata}) {
    _log(ZoniLogLevel.critical, message, metadata);
  }

  /// Generic log method that accepts any log level.
  ///
  /// [level] - The log level
  /// [message] - The message to log
  /// [metadata] - Optional metadata object
  static void log(ZoniLogLevel level, String message, {Object? metadata}) {
    _log(level, message, metadata);
  }

  /// Internal logging implementation.
  static void _log(ZoniLogLevel level, String message, Object? metadata) {
    if (!_isEnabled || !_allowedLevels.contains(level)) return;

    final String timestamp = DateTime.now().toIso8601String().substring(11, 23);
    final String color = _getColor(level);
    final String levelName = level.name.toUpperCase().padRight(8);
    final String logHeader =
        '$color[$_prefix] [$levelName] [$timestamp]$_reset';

    // Build the complete message
    String completeMessage = message;
    if (metadata != null) {
      completeMessage += ' | Metadata: ${metadata.toString()}';
    }

    // Handle long messages by chunking them
    const int chunkSize = 800;
    if (completeMessage.length > chunkSize) {
      final List<String> chunks = _chunkString(completeMessage, chunkSize);
      for (int i = 0; i < chunks.length; i++) {
        final String chunkIndicator =
            chunks.length > 1 ? ' (${i + 1}/${chunks.length})' : '';
        developer.log('$logHeader$chunkIndicator ${chunks[i]}');
      }
    } else {
      developer.log('$logHeader $completeMessage');
    }
  }

  /// Returns ANSI color code for the given log level.
  static String _getColor(ZoniLogLevel level) {
    switch (level) {
      case ZoniLogLevel.debug:
        return _cyan;
      case ZoniLogLevel.info:
        return _blue;
      case ZoniLogLevel.success:
        return _green;
      case ZoniLogLevel.warning:
        return _yellow;
      case ZoniLogLevel.error:
        return _red;
      case ZoniLogLevel.critical:
        return _magenta;
    }
  }

  /// Splits a string into chunks of specified size.
  static List<String> _chunkString(String input, int chunkSize) {
    final List<String> chunks = <String>[];
    for (int i = 0; i < input.length; i += chunkSize) {
      final int end =
          (i + chunkSize < input.length) ? i + chunkSize : input.length;
      chunks.add(input.substring(i, end));
    }
    return chunks;
  }

  /// Enables or disables logging at runtime.
  static void setEnabled(bool enabled) {
    _isEnabled = enabled;
  }

  /// Sets which log levels are allowed to be displayed.
  static void setAllowedLevels(Set<ZoniLogLevel> levels) {
    _allowedLevels = levels;
  }

  /// Gets the current enabled state.
  static bool get isEnabled => _isEnabled;

  /// Gets the currently allowed log levels.
  static Set<ZoniLogLevel> get allowedLevels => Set.from(_allowedLevels);

  /// Quick print function for simple debug output (similar to pp).
  ///
  /// Only works in debug mode and prints with timestamp.
  static void pp(Object? object) {
    if (kDebugMode) {
      final String timestamp =
          DateTime.now().toIso8601String().substring(11, 23);
      print('$_prefix ($timestamp) => $object');
    }
  }

  /// Quick log function for simple debug output (similar to ll).
  ///
  /// Works in debug and profile modes and uses dart:developer log.
  static void ll(Object? object) {
    if (kDebugMode || kProfileMode) {
      final String timestamp =
          DateTime.now().toIso8601String().substring(11, 23);
      developer.log('$_prefix ($timestamp) => $object');
    }
  }
}
