import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_manager_app_hive/screens/new_note_screen.dart';
import 'package:task_manager_app_hive/screens/show_note_screen.dart';

import '../models/note.dart';
import '../models/task.dart';
import '../widgets/notes_widget.dart';
import '../widgets/task_widget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    print(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  Box boxTasks = Hive.box<Task>('tasks');
  Box boxNotes = Hive.box<Note>('notes');
  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = [
      ValueListenableBuilder<Box<Task>>(
        valueListenable: Hive.box<Task>('tasks').listenable(),
        builder: (context, box, _) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return Dismissible(
                direction: DismissDirection.endToStart,
                background: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.delete_outline,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Task is deleted!',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                key: UniqueKey(),
                onDismissed: (direction) {
                  box.delete(box.getAt(index)!.id);
                },
                child: TaskWidget(task: box.getAt(index)),
              );
            },
            itemCount: box.values.length,
          );
        },
      ),
      ValueListenableBuilder(
        valueListenable: Hive.box<Note>('notes').listenable(),
        builder: (context, box, _) {
          return LayoutBuilder(
            builder: (context, constraints) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: constraints.maxWidth > 600 ? 3 : 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return Dismissible(
                      background: Row(
                        children: const [
                          Icon(Icons.delete),
                          Text("This note is deleted!"),
                        ],
                      ),
                      key: UniqueKey(),
                      child: GestureDetector(
                        onTap: () async {
                          final updatedNote = await Navigator.of(context)
                              .pushNamed(ShowNoteScreen.routeName,
                                  arguments: boxNotes.getAt(index)) as Note;
                          setState(() {
                            boxNotes.put(updatedNote.id, updatedNote);
                          });
                        },
                        child: NotesWidget(
                          note: boxNotes.getAt(index),
                        ),
                      ),
                      onDismissed: (direction) {
                        boxNotes.delete(boxNotes.getAt(index)!.id);
                        setState(() {});
                      },
                    );
                  },
                  itemCount: boxNotes.length,
                ),
              );
            },
          );
        },
      ),
    ];
    final titleController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('What\'s up for Today?'),
        actions: [
          (_selectedIndex == 0)
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: TextField(
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                            controller: titleController,
                            autofocus: true,
                            decoration: const InputDecoration(
                              hintText: "Enter new task.",
                              hintStyle: TextStyle(
                                fontSize: 18,
                              ),
                              border: InputBorder.none,
                            ),
                            onSubmitted: (value) {
                              if (value.isEmpty) {
                                return;
                              }
                              Navigator.of(context).pop();
                              DatePicker.showTimePicker(
                                context,
                                currentTime: DateTime.now(),
                                showSecondsColumn: false,
                                onConfirm: (date) {
                                  // ignore: unnecessary_null_comparison
                                  if (date == null) {
                                    return;
                                  }
                                  setState(() {
                                    // tasks.add(Task(
                                    //   id: DateTime.now().toString(),
                                    //   title: value,
                                    //   createdOn: DateTime.now(),
                                    // ));
                                    Task newTask = Task(
                                      id: DateTime.now().toString(),
                                      title: value,
                                      createdOn: date,
                                    );
                                    boxTasks.put(newTask.id, newTask);
                                  });
                                },
                              );
                            },
                          ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                  ),
                )
              : IconButton(
                  onPressed: () async {
                    final newNote = await Navigator.of(context)
                        .pushNamed(NewNoteScreen.routeName) as Note;
                    boxNotes.put(newNote.id, newNote);
                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                ),
        ],
      ),
      body: widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.task_alt),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notes),
            label: 'Notes',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
