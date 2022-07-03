import 'package:flutter/material.dart';

import '../models/note.dart';

class ShowNoteScreen extends StatefulWidget {
  static const routeName = '/show-note';
  const ShowNoteScreen({Key? key}) : super(key: key);

  @override
  State<ShowNoteScreen> createState() => _ShowNoteScreenState();
}

class _ShowNoteScreenState extends State<ShowNoteScreen> {
  @override
  Widget build(BuildContext context) {
    final note = ModalRoute.of(context)!.settings.arguments as Note;
    final titleController = TextEditingController(text: note.title);
    final noteController = TextEditingController(text: note.note);
    final _form = GlobalKey<FormState>();

    void _saveForm() {
      if (titleController.text.isEmpty && noteController.text.isEmpty) {
        Navigator.of(context).pop();
      } else {
        final newNote = Note(
          id: note.id,
          title: titleController.text,
          note: noteController.text,
        );
        Navigator.of(context).pop(newNote);
      }
    }

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
