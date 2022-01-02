import 'package:floor/floor.dart';
import 'package:todoapp/db/todo.dart';

abstract class TodoDao{

  @insert 
  Future<void> insertTask(Todo todo);

  @Query("SELECT * FROM Todo")
  Stream<List<Todo>> findAllTodo();
}