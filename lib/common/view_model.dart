import 'package:flutter/foundation.dart' show ChangeNotifier;

class ViewModel<S> extends ChangeNotifier {
  ViewModel() : _isDisposed = false;

  bool _isDisposed;
  S? _status;

  S get status => _status!;

  set status(S status) {
    if (_isDisposed) {
      print('[vm] view model is disposed, no status updated');
      return;
    }

    print('[vm][$runtimeType] status updated: $status');

    _status = status;
    notifyListeners();
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}
