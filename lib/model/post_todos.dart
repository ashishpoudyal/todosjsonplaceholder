// To parse this JSON data, do
//
//     final postTodos = postTodosFromJson(jsonString);

import 'dart:convert';

PostTodos postTodosFromJson(String str) => PostTodos.fromJson(json.decode(str));

String postTodosToJson(PostTodos data) => json.encode(data.toJson());

class PostTodos {
  PostTodos({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  int userId;
  int id;
  String title;
  bool completed;

  factory PostTodos.fromJson(Map<String, dynamic> json) => PostTodos(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        completed: json["completed"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "completed": completed,
      };
}
