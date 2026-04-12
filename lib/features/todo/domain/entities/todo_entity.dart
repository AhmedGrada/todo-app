abstract class TodoEntity {
  final String id;
  final String uid;
  final String title;
  final String description;
  final DateTime createdAt;
  final bool isCompleted;

  TodoEntity({
    required this.id,
    required this.uid,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.isCompleted,
  });
}
