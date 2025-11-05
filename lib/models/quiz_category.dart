import 'package:flutter/material.dart'; 

class QuizCategory {
  final String id;
  final String name;
  final String description;
  final String icon;
  final int colorValue;
  final String title;
  

  QuizCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.colorValue,
    required this.title,
    
  });

  Color get color => Color(colorValue);
}