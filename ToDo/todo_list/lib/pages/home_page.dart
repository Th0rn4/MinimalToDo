import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/components/add_button.dart';
import 'package:todo_list/components/todo_tile.dart';
import 'package:todo_list/data/database.dart';
import 'package:todo_list/utils/dialog_box.dart';
import 'package:todo_list/utils/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //using Hive to stor local storage
  final _myBox = Hive.box('mybox');
  final _controller = TextEditingController();
  String _searchText = "";

  // Initialize ToDoDatabase
  final ToDoDatabase db = ToDoDatabase();


  @override
  void initState() {
    if (_myBox.get("TODOLIST") == null) {
      db.createInitData();
    } else {
      db.loadData();
    }
    super.initState();
  }
  // update state inside List
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = value ?? false;
    });
    db.updateData();
  }
  //Save a new task to the List
  void saveNewTask() {
    setState(() {
      db.todoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateData();
  }
  //Add a new task, call saveTask to also add to List
  void addNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }
  // Delete specific Task from List
  void deleteTask(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    //Make List for search bar search
    List<List<dynamic>> filteredList = _searchText.isEmpty
        ? db.todoList
        : db.todoList
            .where((item) => item[0].toLowerCase().contains(_searchText.toLowerCase()))
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
        backgroundColor: appBarBackgroundColor,
      ),
      body: Column(
        children: [
          Container(
            //Container for Search Bar
            height: 50.0,
            width: 380,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                //Expands Textfield within Searchbar
                Expanded(
                  child: TextField(
                    // ignore: prefer_const_constructors
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0),
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none,
                      hintText: 'Search',
                      // ignore: prefer_const_constructors
                      prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 10),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        _searchText = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          //List view, to be able to scroll through tasks, ListView allows for scrolling
          Expanded(
            child: ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                if (filteredList.isEmpty) {
                  return const Text("No Results");
                } else {
                  //Enter a tile into the ListView, with functions 
                  return ToDoTile(
                    taskName: filteredList[index][0],
                    taskCompleted: filteredList[index][1],
                    onChanged: (value) => checkBoxChanged(value, index),
                    deleteFunction: (context) => deleteTask(index),
                  );
                }
              },
            ),
          ),
        ],
      ),
      //calling button from button class
      floatingActionButton: AddButton(
        onPressed: addNewTask,
      ),
      backgroundColor: appBarBackgroundColor,
    );
  }
}
