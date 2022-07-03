import 'package:flutter/material.dart';

import '../models/note.dart';

class NotesWidget extends StatelessWidget {
  final Note note;
  const NotesWidget({
    Key? key,
    required this.note,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.01),
            offset: const Offset(0, 4),
            blurRadius: 10,
          ),
        ],
        border: Border.all(
          color: Colors.grey,
          width: 1.5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: Text(  
              (note.note.length) <= 100
                  ? note.note
                  : "${note.note.substring(0, 100)}....",
              style: const TextStyle(
                fontSize: 17,
              ),
            )),
          ],
        ),
      ),
    );
  }
}
