import 'package:flutter/material.dart';

class Tag {
  // name should be unique so should act as the id - TODO: validation
  String name;
  String description;
  int colorValue;

  Tag({
    required this.name,
    required this.description,
    required this.colorValue,
  });

  Color get color => Color(colorValue);

  static int colorToValue(Color color) => color.value;
}