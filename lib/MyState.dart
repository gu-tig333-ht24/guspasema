// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:template/api.dart';
import 'package:provider/provider.dart';
import 'Task.dart';
import 'api.dart' as api;
import 'model.dart';

class MyState extends ChangeNotifier {
  List<Task> _tasks = [];
  List<Task> _filteredTasks = [];
  String _textFieldValue = "hej";
  Task _task = Task("temp", true, 0);

  List get tasks => _tasks;
  List get filteredTasks => _filteredTasks;
  String get textFieldValue => _textFieldValue;
  Task get task => _task;

  void fetchTasks() async {
    var tasks = await getTasks();
    _tasks = tasks;
    notifyListeners();
  }

  void addTask(task) async {
    await api.addTask(task);
    fetchTasks();
  }

  void filterLists(bool? filter) {
    if (filter == null) {
      _filteredTasks = _tasks;
    } else if (filter == true) {
      _filteredTasks = _tasks.where((i) => i.done == true).toList();
    } else {
      _filteredTasks = _tasks.where((i) => i.done == false).toList();
    }
    notifyListeners();
  }

  List<Task> getFilteredList() {
    return _filteredTasks;
  }

  bool? getValue(Task task) {
    notifyListeners();
    return _task.done;
  }

  // void reassignId() {
  //   for (int i = 0; i < _tasks.length; i++) {
  //     //_tasks[i]._taskId = i;
  //     _tasks[i].setId(i);
  //   }
  // }

  void setTask(task) {
    _task = task;
  }

  void changeValue(task, boolean) {
    task.done = boolean;

    notifyListeners();
  }

  void updateTextFieldValue(String text) {
    _textFieldValue = text;
    notifyListeners();
  }

  void addToList(Task task) async {
    tasks.add(task);
    notifyListeners();
  }

  void removeFromList(task) {
    tasks.removeWhere((item) => item.id == task);
    notifyListeners();
  }

  void removeAtList(Task task) {
    //tasks.removeAt(task.id);
    notifyListeners();
  }
}
