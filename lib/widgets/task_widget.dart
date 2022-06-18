import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/task.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({Key? key, required this.task}) : super(key: key);
  final Task? task;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: widget.task!.title);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.1),
            offset: const Offset(0, 4),
            blurRadius: 10,
          ),
        ],
      ),
      child: ListTile(
        leading: GestureDetector(
          onTap: () {
            setState(() {
              widget.task!.isDone = !widget.task!.isDone;
              widget.task!.save();
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: (widget.task!.isDone) ? Colors.green : Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.grey,
                width: 0.8,
              ),
            ),
            child: const Icon(
              Icons.check,
              color: Colors.white,
            ),
          ),
        ),
        title: (widget.task!.isDone)
            ? Text(
                widget.task!.title,
                style: const TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey,
                ),
              )
            : TextField(
                controller: titleController,
                style: const TextStyle(fontSize: 18),
                decoration: const InputDecoration(border: InputBorder.none),
                onSubmitted: (value) {
                  if (value.isEmpty) {
                    return;
                  }
                  widget.task!.title = value;
                  widget.task!.save();
                },
              ),
        trailing: Text(
          DateFormat.jm().format(widget.task!.createdOn),
          style: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
