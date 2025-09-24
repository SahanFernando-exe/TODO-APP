import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:todo_app/firebase_options.dart';
import 'package:todo_app/models/task.dart';
import 'datasource_interface.dart';

class FirebaseDatasource implements DataSourceInterface {
  late FirebaseDatabase _database;

  static Future<DataSourceInterface> createAsync() async {
    debugPrint('fire creation');
    FirebaseDatasource datasource = FirebaseDatasource();
    await datasource.Initialise();
    return datasource;
  }

  Future Initialise() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    _database = FirebaseDatabase.instance;
  }

  DatabaseReference get _tasksRef => FirebaseDatabase.instance.ref('todos');

  /// Add
  ///
  @override
  Future<bool> add(Task model) async {
    debugPrint("add called");
    try {
      DatabaseReference newTaskRef = _tasksRef.push();
      model.id = newTaskRef.key.toString();
      Map<String, dynamic> data = model.toMap();
      await newTaskRef.set(data);
      return true;
    } catch (e) {
      debugPrint('Error adding task: $e');
      return false;
    }
  }

  /// Browse
  ///
  @override
  Future<List<Task>> browse() async {
    List<Task> results = [];
    try {
      DataSnapshot snapshot = await _tasksRef.get();

      if (!snapshot.exists) {
        throw Exception(
          'Invalid Request - Cannot find snapshot at: ${snapshot.ref.path}',
        );
      }

      (snapshot.value as Map).values
          .map((e) => (Map<String, dynamic>.from(e)))
          .forEach((item) {
            debugPrint(item.toString());
            Task task = Task.fromMap(item);
            results.add(task);
          });
    } catch (e) {
      debugPrint('Error browsing tasks: $e');
    }
    return results;
  }

  /// Delete
  ///
  @override
  Future<bool> delete(Task model) async {
    //emergencyFix();
    debugPrint("delete called");
    String? key = _tasksRef.child(model.id).key;
    debugPrint(model.id);
    debugPrint(key);
    try {
      await _tasksRef.child(model.id).remove();
      return true;
    } catch (e) {
      debugPrint('Error deleting task: $e');
      return false;
    }
  }

  /// Edit
  ///
  @override
  Future<bool> edit(Task model) async {
    debugPrint("edit called");
    try {
      Map<String, dynamic> data = model.toMap();
      await _tasksRef.child(model.id).update(data);
      return true;
    } catch (e) {
      debugPrint('Error editting task: $e');
      return false;
    }
  }
}
