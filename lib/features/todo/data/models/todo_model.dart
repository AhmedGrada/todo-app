import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/core/utils/typedef.dart';
import 'package:todo/features/todo/domain/entities/todo_entity.dart';

class TodoModel extends TodoEntity {
  TodoModel({
    required super.id,
    required super.uid,
    required super.title,
    required super.description,
    required super.createdAt,
    required super.isCompleted,
  });

  factory TodoModel.fromJson(Json json) {
    return TodoModel(
      id: json['id'] ?? '',
      uid: json['uid'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      createdAt: json['createdAt'] != null
          ? (json['createdAt'] as Timestamp).toDate()
          : DateTime.now(),
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  Json toJson() {
    return {
      'id': id,
      'uid': uid,
      'title': title,
      'description': description,
      'createdAt': Timestamp.fromDate(createdAt),
      'isCompleted': isCompleted,
    };
  }

  @override
  // Add this inside your TodoModel class
  factory TodoModel.fromEntity(TodoEntity entity) {
    return TodoModel(
      id: entity.id,
      uid: entity.uid,
      title: entity.title,
      description: entity.description,
      createdAt: entity.createdAt,
      isCompleted: entity.isCompleted,
    );
  }
}
