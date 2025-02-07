class Todo {
  final String? id;
  final String title;
  final bool completed;
  final String categoryId;

  Todo(
      {required this.id,
      required this.title,
      this.completed = false,
      required this.categoryId});

  Todo copyWith({
    String? id,
    String? title,
    bool? completed,
    String? categoryId,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
      categoryId: categoryId ?? this.categoryId,
    );
  }

  // Deserialization JSON (tramite factory constructor)
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      completed: json['completed'],
      categoryId: json['categoryId'],
    );
  }

  // Serialization JSON
  Map<String, dynamic> toJson() {

    Map<String, dynamic> map = {
        'id': id,
        'title': title,
        'completed': completed,
        'categoryId': categoryId,
      };

      if (id == null) {
        map.remove('id');
      }

      return map;
  }

      
}
