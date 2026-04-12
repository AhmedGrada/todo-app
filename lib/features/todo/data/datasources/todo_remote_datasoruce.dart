import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/features/todo/data/models/todo_model.dart';
import 'package:todo/features/todo/domain/entities/todo_entity.dart';

class TodoRemoteDatasource {
  TodoRemoteDatasource(this.firestore);

  final FirebaseFirestore firestore;
  final String collectionPath = 'todos';
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  Future<void> addTodo(TodoEntity todo) async {
    final ref = firestore.collection(collectionPath).doc(todo.id);
    final todoModel = TodoModel.fromEntity(todo);
    await ref.set(todoModel.toJson());
  }

  Future<void> updateTodo(TodoEntity todo) async {
    final ref = firestore.collection(collectionPath).doc(todo.id);
    final todoModel = TodoModel.fromEntity(todo);
    await ref.update(todoModel.toJson());
  }

  Future<void> deleteTodo(String id) async {
    final ref = firestore.collection(collectionPath).doc(id);
    await ref.delete();
  }

  Stream<List<TodoEntity>> getTodos() {
    return firestore
        .collection(collectionPath)
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => TodoModel.fromJson(doc.data()))
              .toList();
        });
  }
}
