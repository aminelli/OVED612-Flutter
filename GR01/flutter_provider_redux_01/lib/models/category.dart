// Model per la gestione delle categorie
class Category {
  final String? id;
  final String name;

  Category({
    required this.id,
    required this.name
  });

  Category copyWith({
    String? id,
    String? name,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {

    if (id == null) {
      return {
        'name': name,
      };
    }

    return {
      'id': id,
      'name': name,
    };
  }

}
