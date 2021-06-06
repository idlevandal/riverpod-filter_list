import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'main.dart';

class TodoList extends ConsumerWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final todos = watch(filteredTodos);

    return todos.when(
        loading: () => CircularProgressIndicator(),
        error: (err, st) => Text(err.toString()),
        data: (data) => ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Card(
                clipBehavior: Clip.antiAlias,
                shadowColor: Color(0xFFDDDDDD),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xFFFEFEFE), Color(0xFFF2F2F2)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight)),
                  child: ListTile(
                    leading: Icon(Icons.today_outlined, color: Colors.blueAccent,),
                    title: Text('User Id: ${data[index].userId} ___ Todo Id: ${data[index].id!}'),
                    subtitle: Text(data[index].title!),
                  ),
                ),
              );
            }));
  }
}