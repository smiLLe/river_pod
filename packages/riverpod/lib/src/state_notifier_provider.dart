import 'package:meta/meta.dart';
import 'package:state_notifier/state_notifier.dart';

import 'builders.dart';
import 'framework.dart';
import 'future_provider.dart';
import 'provider.dart';

part 'state_notifier_provider/auto_dispose.dart';
part 'state_notifier_provider/base.dart';

/// {@template riverpod.statenotifierprovider}
/// Creates a [StateNotifier] and expose its current state.
///
/// This provider is used in combination with `package:state_notifier`.
///
/// Combined with [StateNotifier], [StateNotifierProvider] can be used to manipulate
/// advanced states, that would otherwise be difficult to represent with simpler
/// providers such as [Provider] or [FutureProvider].
///
/// For example, you may have a todo-list, where you can add and remove
/// and complete a todo.
/// Using [StateNotifier], you could represent such state as:
///
/// ```dart
/// class TodosNotifier extends StateNotifier<List<Todo>> {
///   TodosNotifier(): super([]);
///
///   void add(Todo todo) {
///     state = [...state, todo];
///   }
///
///   void remove(String todoId) {
///     state = [
///       for (final todo in state)
///         if (todo.id != todoId) todo,
///     ];
///   }
///
///   void toggle(String todoId) {
///     state = [
///       for (final todo in state)
///         if (todo.id == todoId) todo.copyWith(completed: !todo.completed),
///     ];
///   }
/// }
/// ```
///
/// Which you can then pass to a [StateNotifierProvider] like so:
///
/// ```dart
/// final todosProvider = StateNotifierProvider((ref) => TodosNotifier());
/// ```
///
/// And finally, you can interact with it inside your UI:
///
/// ```dart
/// Widget build(BuildContext context, ScopedReader watch) {
///   // rebuild the widget when the todo list changes
///   List<Todo> todos = watch(todosProvider.state);
///
///   return ListView(
///     children: [
///       for (final todo in todos)
///         CheckboxListTile(
///            value: todo.completed,
///            // When tapping on the todo, change its completed status
///            onChanged: (value) => context.read(todosProvider).toggle(todo.id),
///            title: Text(todo.description),
///         ),
///     ],
///   );
/// }
/// ```
/// {@endtemplate}
mixin _StateNotifierStateProviderStateMixin<T>
    on ProviderStateBase<StateNotifier<T>, T> {
  void Function()? removeListener;

  @override
  void valueChanged({StateNotifier<T>? previous}) {
    if (createdValue == previous) {
      return;
    }
    removeListener?.call();
    removeListener = createdValue.addListener(_listener);
  }

  // ignore: use_setters_to_change_properties
  void _listener(T value) {
    exposedValue = value;
  }

  @override
  void dispose() {
    removeListener?.call();
    super.dispose();
  }
}

mixin _StateNotifierProviderStateMixin<T extends StateNotifier<Object?>>
    on ProviderStateBase<T, T> {
  @override
  void valueChanged({T? previous}) {
    if (createdValue == previous) {
      return;
    }

    exposedValue?.dispose();
    exposedValue = createdValue;
  }

  @override
  void exposedValueChanged(T newValue) {
    exposedValue?.dispose();
    exposedValue = newValue;
  }

  @override
  void dispose() {
    exposedValue?.dispose();
    super.dispose();
  }
}
