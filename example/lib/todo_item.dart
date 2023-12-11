import 'package:flutter/widgets.dart';
import 'package:sqlite_wrapper_sample/database_helper.dart';
import 'package:sqlite_wrapper_sample/models.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;

  const TodoItem(this.todo, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => DatabaseHelper().toggleDone(todo),
      onLongPress: () => DatabaseHelper().deleteTodo(todo),
      child: Text(
        "${todo.title} ${(todo.id!)}",
        style: TextStyle(
            fontSize: 15,
            decoration: (todo.done == true
                ? TextDecoration.lineThrough
                : TextDecoration.none)),
      ),
    );
  }
}
