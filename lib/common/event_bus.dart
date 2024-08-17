import 'package:event_bus/event_bus.dart' as eb;
import 'package:movie_flutter/common/log.dart';
import 'package:rxdart/subjects.dart';

const _tag = '[bus]';

class EventBus {
  EventBus._();

  static final instance = EventBus._();

  final _eventBus = eb.EventBus.customController(PublishSubject());

  Stream<T> events<T extends BusEvent>() {
    log.d('$_tag Listening for $T');

    return _eventBus.on<T>();
  }

  void fire<T extends BusEvent>(T event) {
    log.d('$_tag Firing $event');
    _eventBus.fire(event);
  }
}

abstract class BusEvent {
  const BusEvent();
}

class MovieRemovedFromFavoriteEvent extends BusEvent {
  const MovieRemovedFromFavoriteEvent(this.movieId);

  final int movieId;
}
