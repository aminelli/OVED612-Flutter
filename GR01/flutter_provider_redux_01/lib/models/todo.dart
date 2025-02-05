
// Model per gestione todo
class Todo {
  final String id;
  final String title;
  final bool completed;
  final String categoryId;

  Todo({
      required this.id,
      required this.title,
      this.completed = false,
      required this.categoryId
  });

  Todo copyWith({String? id, String? title, bool? completed, String? categoryId}) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
      categoryId: categoryId ?? this.categoryId
    );
  }

}
