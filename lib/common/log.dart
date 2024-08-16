import 'dart:io';

import 'package:logger/logger.dart';

final _printer = PrettyPrinter(
  methodCount: 0,
  errorMethodCount: 8,
  lineLength: 20,
  colors: true,
  printEmojis: false,
);

final log = Logger(
  printer: _printer,
  output: SafeConsoleOutput(),
);

/// Do not print logs for tests environment
class SafeConsoleOutput extends ConsoleOutput {
  SafeConsoleOutput()
      : _isTestEnv = Platform.environment.containsKey('FLUTTER_TEST');

  final bool _isTestEnv;

  @override
  void output(OutputEvent event) {
    if (_isTestEnv) return;
    super.output(event);
  }
}
