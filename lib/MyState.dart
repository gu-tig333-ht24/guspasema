// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:template/api.dart';
import 'api.dart' as api;
import 'model.dart';

class MyState extends ChangeNotifier {
  List<Task> _tasks = [];
  List<Task> _filteredTasks = [];
  String _textFieldValue = "hej";
  bool? filter;

  List get tasks => _tasks;
  List get filteredTasks => _filteredTasks;
  String get textFieldValue => _textFieldValue;

  void fetchTasks() async {
    var tasks = await getTasks();
    _tasks = tasks;
    filterLists();
    await Future.delayed(Duration(seconds: 1));
    notifyListeners();
  }

  void setFilter(bool? filterbool) {
    filter = filterbool;
    notifyListeners();
  }

  void addTask(Task task) async {
    await api.addTask(task);
    fetchTasks();
    notifyListeners();
  }

  void filterLists() {
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
    tasks.remove(task);
    notifyListeners();
  }
}
