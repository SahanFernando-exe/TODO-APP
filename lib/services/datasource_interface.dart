import 'package:todo_app/models/task.dart';

abstract class DataSourceInterface {
  Future<List<Task>> browse();
  Future<bool> add(Task model);
  Future<bool> delete(Task model);
  Future<bool> edit(Task model);
}
