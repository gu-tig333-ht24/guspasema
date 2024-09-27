import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';

class Task {
  String title;
  bool? done = false;
  String? id;

  Task(this.title, this.done, [this.id]);

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      json['title'],
      json['done'],
      json['id'],
    );
  }
//json['${id ?? "id"}']
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'done': done,
    };
  }

  // int? getId() {
  //   if (id != null) {
  //     return id;
  //   } else {
  //     return 0;
  //   }
  // }

  // void decreaseId() {
  //   if (id != null) {
  //     !id--;
  //   }
  // }

  void setId(newId) {
    id = newId;
  }
}
