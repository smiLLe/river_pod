import 'dart:async';

import 'package:mockito/mockito.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod/src/internals.dart';
import 'package:test/test.dart';

void main() {
  test('listen to state changes', () {
    final container = ProviderContainer();
    late void Function(int i) setter;
    final event = Provider<int>((ref) {
      setter = (i) => ref.state = i;
      return 0;
    });
    final provider = Provider<int>((ref) {
      ref.listen<int>(event, (val) {
        ref.state = val;
      });

      return -1;
    });

    expect(container.read(provider), -1);

    container.refresh(event);
    expect(container.read(provider), 0);

    setter(2);
    expect(container.read(provider), 2);
  });

  test('correctly removes listener', () async {
    final container = ProviderContainer();
    final event = Provider<int>((ref) {
      return 0;
    });
    final provider = Provider.autoDispose((ref) {
      ref.listen<int>(event, (state) {});
      return 1;
    });

    final sub = container.listen(provider);

    expect(container.readProviderElement(event).hasListeners, isTrue);

    sub.close();

    await Future<void>.value();
    expect(container.readProviderElement(event).hasListeners, isFalse);
  });

  test('cannot watch and listen at the same time', () {
    final container = ProviderContainer();
    final event = Provider<int>((ref) {
      return 0;
    });
    final cannotWatch = Provider((ref) {
      ref.listen<int>(event, (state) {});
      return ref.watch(event);
    });
    final cannotListen = Provider((ref) {
      final i = ref.watch(event);
      ref.listen<int>(event, (state) {});
      return i;
    });

    runZonedGuarded(() => container.read(cannotWatch), (err, stack) {
      expect(
        err,
        isA<ProviderException>().having(
          (s) => s.exception.toString(),
          'exception.toString',
          contains('Cannot watch Provider'),
        ),
      );
    });

    runZonedGuarded(() => container.read(cannotListen), (err, stack) {
      expect(
        err,
        isA<ProviderException>().having(
          (s) => s.exception.toString(),
          'exception.toString',
          contains('Cannot listen Provider'),
        ),
      );
    });
  });
}

class CallMock extends Mock {
  void call();
}
