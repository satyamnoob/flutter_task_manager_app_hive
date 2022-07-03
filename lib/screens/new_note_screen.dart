import 'package:flutter/material.dart';
import 'package:task_manager_app_hive/models/note.dart';

class NewNoteScreen extends StatefulWidget {
  static const routeName = "/create-note";
  const NewNoteScreen({Key? key}) : super(key: key);

  @override
  State<NewNoteScreen> createState() => _NewNoteScreenState();
}

class _NewNoteScreenState extends State<NewNoteScreen> {
  final titleController = TextEditingController();
  final noteController = TextEditingController();
  final _form = GlobalKey<FormState>();

  void _saveForm() {
    if (titleController.text.isEmpty && noteController.text.isEmpty) {
      Navigator.of(context).pop();
    } else {
      final newNote =  Note(
        id: DateTime.now().toString(),
        title: titleController.text,
        note: noteController.text,
      );
      Navigator.of(context).pop(newNote);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black,
        ),
        title: const Text("Create New Note"),
        actions: [
          IconButton(
            onPressed: () {
              _saveForm();
            },
            icon: const Icon(
              Icons.save,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _form,
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  style: const TextStyle(
                    fontSize: 25,
                  ),
                  cursorColor: Colors.grey,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Title',
                    hintStyle: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                TextFormField(
                  controller: noteController,
                  style: const TextStyle(
                    fontSize: 17,
                  ),
                  cursorColor: Colors.grey,
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Note',
                    hintStyle: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
