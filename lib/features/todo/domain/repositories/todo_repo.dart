import 'package:todo/core/utils/typedef.dart';
import 'package:todo/features/todo/domain/entities/todo_entity.dart';

abstract class TodoRepo {
  FutureVoid addTodo(TodoEntity todo);
  FutureVoid updateTodo(TodoEntity todo);
  FutureVoid deleteTodo(String id);
  Stream<List<TodoEntity>> getTodos();
}
