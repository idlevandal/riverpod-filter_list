import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'main.dart';

class FilterDropdown extends StatefulWidget {
  const FilterDropdown({Key? key}) : super(key: key);

  @override
  _FilterDropdownState createState() => _FilterDropdownState();
}

class _FilterDropdownState extends State<FilterDropdown> {
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
            hint: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text('Filter Todos by user'),
            ),
            // value: _selectedUser, // DON'T set value if using hint
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