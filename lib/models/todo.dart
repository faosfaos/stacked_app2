import 'package:equatable/equatable.dart';
import 'package:o_package/extensions/advanced_model_extensions.dart';

class Todo extends Equatable {
  final int? id;
  final String title;
  final String? content;
  final bool? isDone;

  const Todo({
    this.id,
    required this.title,
    this.content,
    this.isDone,
  });

  Todo copyWith({int? id, String? title, String? content, bool? isDone}) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      isDone: isDone ?? this.isDone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'content': content,
      'isDone': isDone.toIntForNullable(),
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map.getIntNullable("id"),
      title: map.getString("title"),
      content: map.getStringNullable("content"),
      isDone: map.intToBoolFlexible("isDone"),
    );
  }

  @override
  List<Object?> get props => [id, title, content, isDone];
}
