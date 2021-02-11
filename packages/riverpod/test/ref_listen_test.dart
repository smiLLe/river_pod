import 'dart:async';

import 'package:mockito/mockito.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod/src/internals.dart';
import 'package:test/test.dart';

class Counter extends StateNotifier<int> {
  Counter([int initialValue = 0]) : super(initialValue);

  @override
  int get state => super.state;
  @override
  set state(int value) => super.state = value;

  void increment() => state++;
}

void main() {
  test('listen to state changes', () {
    final container = ProviderContainer();
    var i = 0;
    late void Function() setter;
    final event = Provider<int>((ref) {
      setter = () => ref.setState(i);
      return i;
    });
    final provider = Provider<int>((ref) {
      ref.onState<int>(event, (val) {
        ref.setState(val);
      });

      return -1;
    });

    expect(container.read(provider), -1);

    i = 1;
    container.refresh(event);
    expect(container.read(provider), 1);

    i = 2;
    setter();
    expect(container.read(provider), 2);
  });

  test('correctly removes listener', () async {
    final container = ProviderContainer();
    final event = Provider<int>((ref) {
      return 0;
    });
    final provider = Provider.autoDispose((ref) {
      ref.onState<int>(event, (state) {});
      return 1;
    });

    final sub = container.listen(provider);

    expect(container.readProviderElement(event).hasListeners, isTrue);

    sub.close();

    await Future<void>.value();
    expect(container.readProviderElement(event).hasListeners, isFalse);
  });

  test('watch and listen and  the same time', () async {
    final container = ProviderContainer();
    final call = CallMock();
    final event = Provider<int>((ref) {
      return 0;
    });
    final provider = Provider.autoDispose((ref) {
      ref.onState<int>(event, (state) {
        call();
        ref.setState(state);
      });
      return ref.watch(event);
    });

    container.read(provider);
    container.refresh(event);
    verify(call()).called(0);
  });
}

class CallMock extends Mock {
  void call();
}
