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

  @override
  Future<bool> add(Task model) async {
    await _tasksRef.child(model.id).set(model.toMap());
    return true;
  }

  @override
  Future<List<Task>> browse() async {
    List<Task> results = [];
    DataSnapshot snapshot = await _tasksRef.get();

    if (!snapshot.exists) {
      throw Exception(
        'Invalid Request - Cannot find snapshot: ${snapshot.ref}',
      );
    }

    (snapshot.value as Map).values
        .map((e) => (Map<String, dynamic>.from(e)))
        .forEach((item) {
          debugPrint(item.toString());
          Task task = Task.fromMap(item);
          results.add(task);
        });

    return results;
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
