import 'dart:async';

import 'package:mockito/mockito.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

import '../utils.dart';

void main() {
  test('StateNotifierFamily override', () {
    final provider = StateNotifierProvider.family<TestNotifier, int>(
        (ref, a) => TestNotifier());
    final notifier2 = TestNotifier(42);
    final container = ProviderContainer(
      overrides: [provider.overrideWithProvider((ref, a) => notifier2)],
    );

    // access in the child container
    // try to read provider.state before provider and see if it points to the override
    expect(container.read(provider(0).state), 42);
    expect(container.read(provider(0)), notifier2);
  });

  test('can be assigned to provider', () {
    final provider = StateNotifierProvider((_) {
      return TestNotifier();
    });
    final container = ProviderContainer();

    expect(container.read(provider), isA<TestNotifier>());
  });

  test('overriding the provider overrides provider.state too', () {
    final notifier = TestNotifier(42);
    final provider = StateNotifierProvider((_) => TestNotifier());
    final container = ProviderContainer(
      overrides: [
        provider.overrideWithProvider(
            StateNotifierProvider((_) => TestNotifier(10)))
      ],
    );

    // does not crash
    container.updateOverrides([
      provider.overrideWithProvider(StateNotifierProvider((_) => notifier)),
    ]);

    expect(container.read(provider), notifier);
    expect(container.read(provider.state), 42);

    notifier.increment();

    expect(container.read(provider.state), 43);
  });

  test('can specify name', () {
    final provider = StateNotifierProvider(
      (_) => TestNotifier(),
      name: 'example',
    );

    expect(provider.name, 'example');
    expect(provider.state.name, 'example.state');

    final provider2 = StateNotifierProvider((_) => TestNotifier());

    expect(provider2.name, isNull);
    expect(provider2.state.name, isNull);
  });

  test('disposes the notifier when provider is unmounted', () {
    final notifier = TestNotifier();
    final provider = StateNotifierProvider<TestNotifier>((_) {
      return notifier;
    });
    final container = ProviderContainer();

    expect(container.read(provider), notifier);
    expect(notifier.mounted, isTrue);

    container.dispose();

    expect(notifier.mounted, isFalse);
  });

  test(
      'disposes the notifier when provider is unmounted when ref provider changes',
      () async {
    final notifier = TestNotifier();
    final notifier2 = TestNotifier();
    final completer = Completer<void>();
    final watchedProvider = Provider<int>((ref) {
      Future.microtask(() {}).then((value) {
        ref.setState(1);
        completer.complete();
      });
      return 0;
    });
    final provider = StateNotifierProvider<TestNotifier>((ref) {
      return ref.watch(watchedProvider) == 0 ? notifier : notifier2;
    });
    final container = ProviderContainer();

    expect(container.read(provider), notifier);
    expect(notifier.mounted, isTrue);

    await completer.future;

    container.read(provider);
    expect(notifier.mounted, isFalse);
    expect(notifier2.mounted, isTrue);

    container.dispose();

    expect(notifier2.mounted, isFalse);
  });

  test('disposes the notifier when provider is unmounted or on set state',
      () async {
    final notifier = TestNotifier();
    final notifier2 = TestNotifier();
    final completer = Completer<void>();
    final provider = StateNotifierProvider<TestNotifier>((ref) {
      Future(() {
        ref.setState(notifier2);
        completer.complete();
      });
      return notifier;
    });
    final container = ProviderContainer();

    expect(container.read(provider), notifier);
    expect(notifier.mounted, isTrue);

    container.read(provider.state);
    expect(notifier.hasListeners, isTrue);

    await completer.future;

    container.read(provider.state);

    expect(notifier.mounted, isFalse);
    expect(() => notifier.hasListeners, throwsStateError);
    expect(notifier2.mounted, isTrue);
    expect(notifier2.hasListeners, isTrue);

    container.dispose();

    expect(notifier2.mounted, isFalse);
    expect(() => notifier2.hasListeners, throwsStateError);
  });

  test('provider subscribe the callback is never', () async {
    final notifier = TestNotifier();
    final provider = StateNotifierProvider<TestNotifier>((_) {
      return notifier;
    });
    final listener = ControllerListenerMock();
    final container = ProviderContainer();

    final sub = provider.addLazyListener(
      container,
      mayHaveChanged: () {},
      onChange: listener,
    );

    verify(listener(argThat(isA<TestNotifier>()))).called(1);
    verifyNoMoreInteractions(listener);

    notifier.increment();

    verifyNoMoreInteractions(listener);
    sub.read();

    verifyNoMoreInteractions(listener);

    container.dispose();
    await Future.value(null);

    verifyNoMoreInteractions(listener);
  });

  test('provider subscribe callback never called', () async {
    final provider = StateNotifierProvider<TestNotifier>((_) {
      return TestNotifier();
    });
    final listener = ListenerMock();
    final container = ProviderContainer();

    final sub = provider.state.addLazyListener(
      container,
      mayHaveChanged: () {},
      onChange: listener,
    );

    verify(listener(0)).called(1);
    verifyNoMoreInteractions(listener);

    container.read(provider).increment();

    verifyNoMoreInteractions(listener);
    sub.read();
    verify(listener(1)).called(1);
    verifyNoMoreInteractions(listener);

    container.dispose();
    await Future.value(null);

    verifyNoMoreInteractions(listener);
  });
}

class TestNotifier extends StateNotifier<int> {
  TestNotifier([int initialValue = 0]) : super(initialValue);

  void increment() => state++;
}

class ListenerMock extends Mock {
  void call(int value);
}

class ControllerListenerMock extends Mock {
  void call(TestNotifier? value);
}
