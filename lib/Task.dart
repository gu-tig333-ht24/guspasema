import "main.dart";
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class Task {
  String taskName = "no name";
  bool? isComplete = true;
  int _taskId = 0;

  int get id => _taskId;

  Task(this.taskName, this.isComplete, this._taskId) {
    _taskId++;
    UniqueKey();
  } //constructor för task

  void decreaseId() {
    _taskId--;
  }

  void setId(id) {
    _taskId = id;
  }
}
