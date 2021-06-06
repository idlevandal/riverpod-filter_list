import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_filter/todo.dart';
import 'package:riverpod_filter/todo_list.dart';
import 'package:riverpod_filter/todo_service.dart';

import 'filter_dropdown.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

final todosProvider = FutureProvider<List<Todo>>((ref) {
  return getTodos();
});

final todoListFilter = StateProvider<String>((ref) {
  return 'all';
});

final filteredTodos = FutureProvider<List<Todo>>((ref) async {
  final filter = ref.watch(todoListFilter);
  final allTodos = await ref.watch(todosProvider.future);
  if (filter.state == 'all') {
    return allTodos;
  } else {
    int _id = int.parse(filter.state.substring(filter.state.length - 1));
    return allTodos.where((el) => el.userId == _id).toList();
  }
});

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            FilterDropdown(),
            Expanded(child: Center(child: TodoList())),
          ],
        )
      ),
    );
  }
}

