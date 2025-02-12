class Todo {
  final String id;
  final String title;
  final String categoryId;
  final bool completed;

  Todo({
    required this.id,
    required this.title,
    required this.categoryId,
    required this.completed,
  });

  Todo copyWith({
    String? id,
    String? title,
    String? categoryId,
    bool? completed,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      categoryId: categoryId ?? this.categoryId,
      completed: completed ?? this.completed,
    );
  }

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      categoryId: json['categoryId'],
      completed: json['completed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'categoryId': categoryId,
      'completed': completed,
    };
  }


}
