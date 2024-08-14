// We group in this file Result Monad related classes and functions.
// ignore_for_file: prefer-match-file-name

import 'package:result_monad/result_monad.dart' as r;

export 'package:result_monad/result_monad.dart';

typedef Result<T> = r.Result<T, dynamic>;

typedef EmptyResult = Result<EmptyContent>;

final EmptyResult emptyOk = EmptyResult.ok(const EmptyContent());

class EmptyContent {
  const EmptyContent();
}
