import 'package:logger/logger.dart';

final _printer = PrettyPrinter(
  methodCount: 0,
  errorMethodCount: 8,
  lineLength: 20,
  colors: true,
  printEmojis: false,
  printTime: false,
);

final log = Logger(
  printer: _printer,
  output: ConsoleOutput(),
);
