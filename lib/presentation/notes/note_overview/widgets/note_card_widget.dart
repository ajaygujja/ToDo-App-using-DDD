import 'package:flutter/material.dart';
import 'package:flutter_ddd/domain/notes/note.dart';
import 'package:flutter_ddd/domain/notes/todo_item.dart';
import 'package:kt_dart/collection.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({Key? key, required this.note}) : super(key: key);

  final Note note;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            note.body.getOrCrash(),
            style: const TextStyle(fontSize: 18),
          ),
          if (note.todos.length > 0) ...[
            const SizedBox(
              height: 4,
            ),
            Wrap(
              spacing: 8,
              children: [
                ...note.todos
                    .getOrCrash()
                    .map((todo) => TodoDisplay(
                          todo: todo,
                        ))
                    .iter,
              ],
            )
          ]
        ],
      ),
    );
  }
}

class TodoDisplay extends StatelessWidget {
  const TodoDisplay({Key? key, required this.todo}) : super(key: key);

  final TodoItem todo;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (todo.done)
          Icon(
            Icons.check_box,
            color: Theme.of(context).colorScheme.secondary,
          ),
        if (!todo.done)
          Icon(
            Icons.check_box_outline_blank,
            color: Theme.of(context).disabledColor,
          ),
        Text(todo.name.getOrCrash())
      ],
    );
  }
}
