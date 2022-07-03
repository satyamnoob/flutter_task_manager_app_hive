import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_manager_app_hive/screens/show_note_screen.dart';

import './models/task.dart';
import './screens/home_screen.dart';
import './screens/new_note_screen.dart';
import 'models/note.dart';

late Box boxTask;
late Box boxNote;
void main() async{
  //initializing Hive
  await Hive.initFlutter();
  Hive.registerAdapter<Task>(TaskAdapter());
  Hive.registerAdapter<Note>(NoteAdapter());
  boxTask = await Hive.openBox<Task>('tasks');
  boxNote = await Hive.openBox<Note>('notes');
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
      routes: {
        NewNoteScreen.routeName:(context) => NewNoteScreen(),
        ShowNoteScreen.routeName: (context) =>  ShowNoteScreen(),
      },
    );
  }
}