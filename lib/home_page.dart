import 'package:flutter/material.dart';
import 'package:riverpod_filter/todo_list.dart';

import 'filter_dropdown.dart';

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