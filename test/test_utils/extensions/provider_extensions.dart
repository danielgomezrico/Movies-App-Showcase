// Group all extensions in one file
// ignore_for_file: prefer-correct-test-file-name

import 'dart:async';

import 'package:movie_flutter/common/view_model.dart';

extension AsStream<S> on ViewModel<S> {
  Stream<S> statusChanges() {
    final controller = StreamController<S>();

    void notify() {
      controller.add(status); // Ask stream to send counter values as event.
    }

    addListener(notify);
    controller.onCancel = () => removeListener(notify);

    Future<void>.delayed(const Duration(seconds: 5))
        .then((_) => controller.close());

    return controller.stream;
  }

  StreamController<S> statusChangesController() {
    final controller = StreamController<S>();

    void notify() {
      controller.add(status); // Ask stream to send counter values as event.
    }

    addListener(notify);
    controller.onCancel = () => removeListener(notify);

    Future<void>.delayed(const Duration(seconds: 5))
        .then((_) => controller.close());

    return controller;
  }
}
