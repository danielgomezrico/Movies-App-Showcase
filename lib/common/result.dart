// We group in this file Result Monad related classes and functions.
// ignore_for_file: prefer-match-file-name

import 'package:result_monad/result_monad.dart' as r;

export 'package:result_monad/result_monad.dart';

typedef Result<T> = r.Result<T, dynamic>;

typedef PagedResult<T> = Result<PagedContent<T>>;

typedef EmptyResult = Result<EmptyContent>;

final EmptyResult emptyOk = EmptyResult.ok(const EmptyContent());

class EmptyContent {
  const EmptyContent();
}

class PagedContent<T> {
  const PagedContent({
    required this.page,
    required this.totalPages,
    required this.totalResults,
    required this.payload,
  });

  final int page;
  final int totalPages;
  final int totalResults;
  final T payload;
}
