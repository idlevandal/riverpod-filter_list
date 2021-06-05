import 'dart:convert';

import 'package:http/http.dart';
import 'package:riverpod_filter/todo.dart';

Future<List<Todo>> getTodos() async {
  Response res = await get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));

  List<dynamic> response = jsonDecode(res.body);

  return response.map((todo) => Todo.fromJson(todo)).toList();
}