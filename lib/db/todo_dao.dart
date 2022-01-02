import 'package:floor/floor.dart';
import 'package:todoapp/db/todo.dart';

@dao
abstract class TodoDao{

  @insert 
  Future<void> insertTask(Todo todo);

  @Query("SELECT * FROM Todo")
  Stream<List<Todo>> findAllTodo();

  @Query("SELECT * FROM Todo ORDER BY id DESC LIMIT 1")
  Future<Todo?> findTodoLast();

  @Query("DELETE FROM Todo WHERE id=:id")
  Future<void> deleteById(int id);
}