import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import './models/task.dart';
import 'screens/home_screen.dart';

late Box box;
void main() async{
  //initializing Hive
  await Hive.initFlutter();
  Hive.registerAdapter<Task>(TaskAdapter());
  box = await Hive.openBox<Task>('tasks');
  // Task newTask = Task(id: DateTime.now().toString(), title: 'Default Task', createdOn: DateTime.now());
  // box.put(newTask.id, newTask);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Colors.white,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ), 
      ),
      home: HomeScreen(),
    );
  }
}