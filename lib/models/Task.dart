import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String description;
  @HiveField(3)
  bool isCompleted;

  // Validation constants
  static const int minTitleLength = 1;
  static const int maxTitleLength = 15;
  static const int minDescriptionLength = 0;
  static const int maxDescriptionLength = 50;

  Task({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
  }) {
    // Validate during construction
    if (!_isValidTitle(title)) {
      throw ArgumentError(
        'Title must be between $minTitleLength and $maxTitleLength characters',
      );
    }
    if (!_isValidDescription(description)) {
      throw ArgumentError(
        'Description must be between $minDescriptionLength and $maxDescriptionLength characters',
      );
    }
  }

  // Private validation methods
  bool _isValidTitle(String title) {
    return title.length >= minTitleLength && title.length <= maxTitleLength;
  }

  bool _isValidDescription(String description) {
    return description.length >= minDescriptionLength &&
        description.length <= maxDescriptionLength;
  }

  // Public validation methods for UI to use
  static String? validateTitle(String? title) {
    if (title == null || title.isEmpty) {
      return 'Title is required';
    }
    if (title.length < minTitleLength) {
      return 'Title must be at least $minTitleLength characters';
    }
    if (title.length > maxTitleLength) {
      return 'Title cannot exceed $maxTitleLength characters';
    }
    return null; // Return null if valid
  }

  static String? validateDescription(String? description) {
    if (description == null) return null; // Description can be empty

    if (description.length > maxDescriptionLength) {
      return 'Description cannot exceed $maxDescriptionLength characters';
    }
    return null; // Return null if valid
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': title,
      'description': description,
      'complete': isCompleted,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    bool? complete = map['complete'] is bool ? map['complete'] : null;
    complete ??= map['complete'] == 1 ? true : false;

    return Task(
      id: map['id'].toString(),
      title: map['name'],
      description: map['description'],
      isCompleted: complete,
    );
  }
}

class TaskAdapter extends TypeAdapter<Task> {
  @override
  int get typeId => 0;

  @override
  Task read(BinaryReader reader) {
    return Task(
      id: reader.read(),
      title: reader.read(),
      description: reader.read(),
      isCompleted: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer.write(obj.id);
    writer.write(obj.title);
    writer.write(obj.description);
    writer.write(obj.isCompleted);
  }
}
