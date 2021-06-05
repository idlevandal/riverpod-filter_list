import 'package:json_annotation/json_annotation.dart';

part 'todo.g.dart';

@JsonSerializable()
class Todo {
  int? _userId;
  int? _id;
  String? _title;
  bool? _completed;

  int? get userId => _userId;
  int? get id => _id;
  String? get title => _title;
  bool? get completed => _completed;

  Todo({
      int? userId, 
      int? id, 
      String? title, 
      bool? completed}){
    _userId = userId;
    _id = id;
    _title = title;
    _completed = completed;
}

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["userId"] = _userId;
    map["id"] = _id;
    map["title"] = _title;
    map["completed"] = _completed;
    return map;
  }

}