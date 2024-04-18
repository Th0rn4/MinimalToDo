import 'package:flutter/material.dart';
import 'package:todo_list/pages/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {

  // init hive
  await Hive.initFlutter();

  //open a box
  var box = await Hive.openBox('mybox');

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
