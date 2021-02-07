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
  test(
      'Provider removing one of multiple listeners on a provider still listen to the provider',
      () {
    final container = ProviderContainer();
    final event = StateProvider((_) => 0);
    final provider = Provider((ref) {
      ref.onState<StateController<int>>(event, (ctrl) {
        ref.setState(ctrl.state);
      });

      return ref.read(event).state;
    });

    expect(container.read(provider), 0);
    container.read(event).state = 1;
    expect(container.read(provider), 1);
  });
}
