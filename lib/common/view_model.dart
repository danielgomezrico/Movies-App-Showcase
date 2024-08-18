import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:movie_flutter/common/log.dart';

class ViewModel<S> extends ChangeNotifier {
  ViewModel() : _isDisposed = false;

  bool _isDisposed;
  S? _status;

  S get status => _status!;

  set status(S status) {
    if (_isDisposed) {
      log.i('[vm] view model is disposed, no status updated');
      return;
    }

    log.i('[vm] status updated: $status');

    _status = status;
    notifyListeners();
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}
