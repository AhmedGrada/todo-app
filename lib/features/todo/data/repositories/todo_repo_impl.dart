import 'package:todo/core/remote/remote_call.dart';
import 'package:todo/core/utils/typedef.dart';
import 'package:todo/features/todo/data/datasources/todo_remote_datasoruce.dart';
import 'package:todo/features/todo/domain/entities/todo_entity.dart';
import 'package:todo/features/todo/domain/repositories/todo_repo.dart';

class TodoRepoImpl implements TodoRepo {
  TodoRepoImpl(this.remoteDatasource);

  final TodoRemoteDatasource remoteDatasource;

  @override
  FutureVoid addTodo(TodoEntity todo) async {
    return executeRemoteCall(() => remoteDatasource.addTodo(todo));
  }

  @override
  FutureVoid deleteTodo(String id) async {
    return executeRemoteCall(() => remoteDatasource.deleteTodo(id));
  }

  @override
  Stream<List<TodoEntity>> getTodos() {
    return remoteDatasource.getTodos();
  }

  @override
  FutureVoid updateTodo(TodoEntity todo) async {
    return executeRemoteCall(() => remoteDatasource.updateTodo(todo));
  }
}
