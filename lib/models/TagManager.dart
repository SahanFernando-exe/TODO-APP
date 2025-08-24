import 'package:flutter/material.dart';
import 'Tag.dart';

class TagManager with ChangeNotifier {
  List<Tag> _tags = [];
  
  List<Tag> get tags => _tags;
  
  void addTag(Tag tag) {
    _tags.add(tag);
    notifyListeners();
  }
  
  void removeTag(String name) {
    _tags.removeWhere((tag) => tag.name == name);
    notifyListeners();
  }
  
  Tag? getTag(String name) {
    return _tags.firstWhere((tag) => tag.name == name);
  }
}