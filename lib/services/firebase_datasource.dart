import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:todo_app/models/task.dart';
import 'datasource_interface.dart';

class FirebaseDatasource implements DataSourceInterface{
  static Future<DataSourceInterface> createAsync() async {
    FirebaseDatasource datasource = FirebaseDatasource();
    await datasource.Initialise();
    return datasource;
  }

  Future Initialise() async {
    await Firebase.initializeApp();
  }

  DatabaseReference get _tasksRef =>
    FirebaseDatabase.instance.ref().child('tasks');

  @override
  Future<bool> add(Task model) async {
    await _tasksRef.child(model.id).set(model.toMap());
    return true;
  }

  @override
  Future<List<Task>> browse() {
    // TODO: implement browse
    throw UnimplementedError();
  }

  @override
  Future<bool> delete(Task model) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<bool> edit(Task model) {
    // TODO: implement edit
    throw UnimplementedError();
  }
}