import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_filter/todo.dart';
import 'package:riverpod_filter/todo_service.dart';

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
            MyDropdown(),
            Expanded(child: Center(child: TodoList())),
          ],
        )
      ),
    );
  }
}

class MyDropdown extends StatefulWidget {
  const MyDropdown({Key? key}) : super(key: key);

  @override
  _MyDropdownState createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {
  List<String> _items = ['all', 'User 1', 'User 2', 'User 3', 'User 4', 'User 5'];
  late String _selectedUser;

  @override
  void initState() {
    super.initState();
    _selectedUser = _items[0];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.white,
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            dropdownColor: Colors.white,
            isExpanded: true,
            hint: Text('Select User'),
            value: _selectedUser,
            onChanged: (String? val) {
              context.read(todoListFilter).state = val ?? 'all';
              setState(() {
                _selectedUser = val!;
              });
            },
            items: _items.map((String el) {
              return DropdownMenuItem<String>(
                value: el,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                  child: Text(el, style: TextStyle(fontWeight: el == _selectedUser ? FontWeight.w600 : FontWeight.normal),),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}


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
                          colors: [Color(0xFFf6f6f6), Color(0xFFDDDDDD)],
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
