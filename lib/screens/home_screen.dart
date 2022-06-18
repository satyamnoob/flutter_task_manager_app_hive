import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/task.dart';
import '../widgets/task_widget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  // List<Task> tasks = [
  //   Task(
  //     id: '0',
  //     title: 'First Task',
  //     createdOn: DateTime.now(),
  //     // isDone: true,
  //   ),
  //   Task(
  //     id: '1',
  //     title: 'Second Task',
  //     createdOn: DateTime.now(),
  //     isDone: true,
  //   ),
  // ];
  Box box = Hive.box<Task>('tasks');
  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('What\'s up for Today?'),
        actions: [
          Padding(
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
                              box.put(newTask.id, newTask);
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
          ),
        ],
      ),
      body: ValueListenableBuilder<Box<Task>>(
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
    );
  }
}
