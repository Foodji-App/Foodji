library observables;
//https://blog.yadunandan.xyz/dart/flutter/2021/07/03/how-to-write-your-own-observables-in-dart.html

List<Observable> _observablesReadInLastFrame = [];

///runs the passed function once finds the observables involved, listens for changes of those
///observables runs the passed function again when there is update for any involved observables,
///if no observable is detected an exception is thrown
MultiObservableListener runOnceAndRunForEveryChange(void Function() fn) {
  _observablesReadInLastFrame.clear();
  fn();
  final observablesinvolved = _observablesReadInLastFrame.toList();
  _observablesReadInLastFrame.clear();
  if (observablesinvolved.isEmpty) {
    throw Exception("No observables detected");
  }
  return MultiObservableListener(
    observablesinvolved.map((e) => e.listen(fn)).toList(),
  );
}

///onject holding reference to multiple listeners involved in [runOnceAndRunForEveryChange]
class MultiObservableListener {
  final List<ObservableListener> _listeners;

  MultiObservableListener(this._listeners);

  ///stops listening for every observable change involved in [runOnceAndRunForEveryChange]
  void stopListening() {
    for (var element in _listeners) {
      element.stopListening();
    }
  }
}

///object holding reference to listening of aobservable
class ObservableListener {
  ///the function which should be run when the participating observable changes
  final void Function() _onChange;

  ///the participating observable
  final Observable _observable;

  //constructor
  ObservableListener(
    this._observable,
    this._onChange,
  );

  ///stop listening for updates
  void stopListening() {
    _observable._removeListener(this);
  }
}

class Observable<T> {
  ///value the observable is holding
  T _value;

  ///all the listeners listening to this observable currently
  List<ObservableListener> listeners = [];

  ///constructor with default value
  Observable(this._value);

  ///add a listener function to this observable, we'll return a reference so user can dispose/stop listening
  ObservableListener listen(Function() fn) {
    final newListener = ObservableListener(this, fn);
    listeners.add(newListener);
    return newListener;
  }

  ///removes the given listener from list [_listeners]
  void _removeListener(ObservableListener listener) {
    listeners.remove(listener);
  }

  ///get current value of the observable
  T get value {
    _informRead();
    return _value;
  }

  ///set the current value of the observable
  set value(T value) {
    _value = value;
    _informWrite();
  }

  void _informRead() {
    _observablesReadInLastFrame.add(this);
  }

  void _informWrite() {
    for (var element in listeners) {
      element._onChange();
    }
  }
}

// OBSERVABLE DATA

Observable activePage = Observable<int>(-1);

void setActivePage(page) {
  activePage.value = page;
}

int getActivePage() {
  return activePage.value;
}
