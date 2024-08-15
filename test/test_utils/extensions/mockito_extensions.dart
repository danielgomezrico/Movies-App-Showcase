import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_flutter/common/result.dart';

extension ResultMock<T> on PostExpectation<Future<Result<T>>> {
  void thenOk(T body) {
    final result = Result.ok(body);

    thenAnswer((_) => Future.value(result));
  }

  void thenError({String message = 'error'}) {
    final result = Result<T>.error(message);

    thenAnswer((_) => Future.value(result));
  }
}

extension PagedMock<T> on PostExpectation<Future<PagedResult<T>>> {
  void thenOk(
    T body, {
    int page = 1,
    int totalPages = 1,
    int totalResults = 1,
  }) {
    final result = PagedResult.ok(PagedContent(
      page: page,
      totalPages: totalPages,
      totalResults: totalResults,
      payload: body,
    ));

    thenAnswer((_) => Future.value(result));
  }
}

extension FutureMock<T> on PostExpectation<Future<T>> {
  void thenFuture(T body) {
    thenAnswer((realInvocation) => Future.value(body));
  }

  void thenFutureInOrder(List<T> bodies) {
    final answers = Queue.of(bodies);

    thenAnswer((_) {
      if (answers.isEmpty) {
        throw StateError('thenReturnInOrder does not have enough answers');
      }

      return Future.value(answers.removeFirst());
    });
  }
}
