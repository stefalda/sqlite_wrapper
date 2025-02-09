import 'dart:convert';

class Todo {
  int? id;
  String title;
  bool done = false;

  Todo({required this.title});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'done': done,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(title: map['title'] ?? '')
      ..done = (map['done'] ?? 0) == 1 ? true : false
      ..id = (map['id']);
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) => Todo.fromMap(json.decode(source));
}
