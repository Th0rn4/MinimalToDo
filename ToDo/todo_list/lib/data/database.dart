import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/pages/home_page.dart';

void main() async {
  // Initialize Hive
  await Hive.initFlutter();
  // Open a box
  await Hive.openBox('mybox');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
class ToDoDatabase {
  final _myBox = Hive.box('mybox');
  late List<List<dynamic>> todoList;

  void createInitData() {
    todoList = [
      ["Sample Task 1", false],
      ["Sample Task 2", true],
      // Add defaults.
    ];
    updateData();
  }

  void loadData() {
    var data = _myBox.get("TODOLIST");
    if (data != null && data is List<dynamic>) {
      todoList = List<List<dynamic>>.from(data);
    } else {
      todoList = [];
    }
  }

  void updateData() {
    _myBox.put("TODOLIST", todoList);
  }
}