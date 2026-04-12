import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/features/todo/domain/entities/todo_entity.dart';
import 'package:todo/features/todo/domain/repositories/todo_repo.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit(this.todoRepo) : super(TodoInitial());

  final TodoRepo todoRepo;

  StreamSubscription<List<TodoEntity>>? _todosSubscription;

  void fetchTodos() {
    emit(TodoLoading());
    _todosSubscription = todoRepo.getTodos().listen(
      (todos) {
        emit(TodoLoaded(todos: todos));
      },
      onError: (error, stackTrace) {
        emit(TodoError(errorMessage: error.toString()));
      },
    );
  }

  Future<void> addTodo(TodoEntity todo) async {
    emit(TodoLoading());
    final result = await todoRepo.addTodo(todo);
    result.fold(
      (failure) => emit(TodoError(errorMessage: failure.errorMessage)),
      (r) => (),
    );
  }

  Future<void> updateTodo(TodoEntity todo) async {
    emit(TodoLoading());
    final result = await todoRepo.updateTodo(todo);
    result.fold(
      (failure) => emit(TodoError(errorMessage: failure.errorMessage)),
      (r) => (),
    );
  }

  Future<void> deleteTodo(String id) async {
    emit(TodoLoading());
    final result = await todoRepo.deleteTodo(id);
    result.fold(
      (failure) => emit(TodoError(errorMessage: failure.errorMessage)),
      (r) => (),
    );
  }

  @override
  Future<void> close() {
    _todosSubscription?.cancel();
    return super.close();
  }
}
