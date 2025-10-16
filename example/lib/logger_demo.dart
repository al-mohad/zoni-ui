import 'package:flutter/material.dart';
import 'package:zoni_ui/zoni_ui.dart';

/// Demo page showing ZoniUI logger functionality.
class LoggerDemoPage extends StatefulWidget {
  const LoggerDemoPage({super.key});

  @override
  State<LoggerDemoPage> createState() => _LoggerDemoPageState();
}

class _LoggerDemoPageState extends State<LoggerDemoPage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();

    // Initialize the logger with custom settings
    ZoniUI.initializeLogger(
      isEnabled: true,
      allowedLevels: ZoniLogLevel.values.toSet(),
      prefix: 'ZoniDemo',
    );

    // Log initialization
    ZoniUI.logInfo('Logger demo page initialized');
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });

    // Log the counter increment with metadata
    ZoniUI.logDebug(
      'Counter incremented',
      metadata: <String, Object>{
        'previousValue': _counter - 1,
        'newValue': _counter,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );

    // Log different levels based on counter value
    if (_counter == 5) {
      ZoniUI.logSuccess('Counter reached 5!');
    } else if (_counter == 10) {
      ZoniUI.logWarning('Counter is getting high (10)');
    } else if (_counter == 15) {
      ZoniUI.logError('Counter is too high (15)');
    } else if (_counter >= 20) {
      ZoniUI.logCritical('Counter is critically high (20+)');
    }
  }

  void _resetCounter() {
    final int oldValue = _counter;
    setState(() {
      _counter = 0;
    });

    ZoniUI.logInfo(
      'Counter reset',
      metadata: <String, int>{'oldValue': oldValue, 'newValue': _counter},
    );
  }

  void _demonstrateQuickLogging() {
    ZoniUI.pp('This is a quick print message');
    ZoniUI.ll('This is a quick log message');
  }

  void _demonstrateAllLogLevels() {
    ZoniUI.logDebug('This is a debug message');
    ZoniUI.logInfo('This is an info message');
    ZoniUI.logSuccess('This is a success message');
    ZoniUI.logWarning('This is a warning message');
    ZoniUI.logError('This is an error message');
    ZoniUI.logCritical('This is a critical message');
  }

  void _demonstrateGenericLog() {
    ZoniUI.log(
      ZoniLogLevel.info,
      'This is a generic log message',
      metadata: <String, String>{'method': 'generic', 'level': 'info'},
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('ZoniUI Logger Demo'),
          backgroundColor: ZoniUI.colors.primary,
          foregroundColor: ZoniColors.onPrimary,
        ),
        body: Padding(
          padding: EdgeInsets.all(ZoniUI.spacing.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Counter Value:',
                style: ZoniUI.textStyles.headlineSmall,
              ),
              SizedBox(height: ZoniUI.spacing.sm),
              Text(
                '$_counter',
                style: ZoniUI.textStyles.displayMedium.copyWith(
                  color: ZoniUI.colors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: ZoniUI.spacing.xl),

              // Counter controls
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ZoniButton(
                    onPressed: _incrementCounter,
                    child: const Text('Increment'),
                  ),
                  ZoniButton(
                    onPressed: _resetCounter,
                    variant: ZoniButtonVariant.outlined,
                    child: const Text('Reset'),
                  ),
                ],
              ),

              SizedBox(height: ZoniUI.spacing.xl),

              // Logger demonstration buttons
              Text(
                'Logger Demonstrations:',
                style: ZoniUI.textStyles.titleMedium,
              ),
              SizedBox(height: ZoniUI.spacing.md),

              Wrap(
                spacing: ZoniUI.spacing.sm,
                runSpacing: ZoniUI.spacing.sm,
                alignment: WrapAlignment.center,
                children: <Widget>[
                  ZoniButton(
                    onPressed: _demonstrateAllLogLevels,
                    size: ZoniButtonSize.small,
                    child: const Text('All Log Levels'),
                  ),
                  ZoniButton(
                    onPressed: _demonstrateQuickLogging,
                    size: ZoniButtonSize.small,
                    variant: ZoniButtonVariant.outlined,
                    child: const Text('Quick Logging'),
                  ),
                  ZoniButton(
                    onPressed: _demonstrateGenericLog,
                    size: ZoniButtonSize.small,
                    variant: ZoniButtonVariant.text,
                    child: const Text('Generic Log'),
                  ),
                ],
              ),

              SizedBox(height: ZoniUI.spacing.xl),

              // Instructions
              ZoniCard(
                child: Padding(
                  padding: EdgeInsets.all(ZoniUI.spacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Instructions:',
                        style: ZoniUI.textStyles.titleSmall.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: ZoniUI.spacing.sm),
                      Text(
                        "1. Open your browser's developer console\n"
                        '2. Click the buttons to see different log messages\n'
                        '3. Increment the counter to see contextual logging\n'
                        '4. Notice the colored output and metadata',
                        style: ZoniUI.textStyles.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
