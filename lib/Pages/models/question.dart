import 'package:flutter/material.dart';

class Question{
  final Image image;
  final String id;

  final String title;

  final Map<String, bool> options;

  Question({
    required this.id,
    required this.title,
    required this.options,
    required this.image
  });
  @override
  
  String toString() {
    return 'Question(id: $id, title: $title, options: $options)';
  }
}