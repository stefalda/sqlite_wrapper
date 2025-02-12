import 'package:flutter/widgets.dart';
import 'package:inject_x/inject_x.dart';
import 'package:sqlite_wrapper_sample/models.dart';
import 'package:sqlite_wrapper_sample/services/database_service.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;

  const TodoItem(this.todo, {super.key});

  @override
  Widget build(BuildContext context) {
    final databaseService = inject<DatabaseService>();
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => databaseService.toggleDone(todo),
      onLongPress: () => databaseService.deleteTodo(todo),
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
