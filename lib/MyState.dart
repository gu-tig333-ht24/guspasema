import "main.dart";
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'Task.dart';

class MyState extends ChangeNotifier {
  final List<Task> _tasks = [];
  List<Task> _filteredTasks = [];
  String _textFieldValue = "";
  int _taskId = 0;
  Task _task = Task("temp", true, 0);

  List<Task> _listDone = [];
  List<Task> _listunDone = [];

  List get tasks => _tasks;
  List get filteredTasks => _filteredTasks;
  List get listDone => _listDone;
  List get listunDone => _listunDone;
  String get textFieldValue => _textFieldValue;
  int get taskId => _taskId;
  Task get task => _task;

  void filterLists(bool? filter) {
    if (filter == null) {
      _filteredTasks = _tasks;
    } else if (filter == true) {
      _filteredTasks = _tasks.where((i) => i.isComplete == true).toList();
    } else {
      _filteredTasks = _tasks.where((i) => i.isComplete == false).toList();
    }
    notifyListeners();
  }

  List<Task> getFilteredList() {
    return _filteredTasks;
  }

  List<Task> getWholeList() {
    return _tasks;
  }

  List<Task> getListDone() {
    return _listDone;
  }

  List<Task> GetlistunDone() {
    return _listunDone;
  }

  bool? getValue(Task task) {
    notifyListeners();
    return _task.isComplete;
  }

  void reassignId() {
    for (int i = 0; i < _tasks.length; i++) {
      //_tasks[i]._taskId = i;
      _tasks[i].setId(i);
    }
  }

  void setTask(task) {
    _task = task;
  }

  void changeValue(id, boolean) {
    tasks[id].isComplete = boolean;

    notifyListeners();
  }

  void increamentId() {
    _taskId++;
    notifyListeners();
  }

  void decreaseId() {
    _taskId--;
    notifyListeners();
  }

  void updateTextFieldValue(String text) {
    _textFieldValue = text;
    notifyListeners();
  }

  void addToList(task) {
    tasks.add(task);
    notifyListeners();
  }

  void removeFromList(task) {
    tasks.removeWhere((item) => item.id == task);
    notifyListeners();
  }

  void removeAtList(Task task) {
    tasks.removeAt(task.id);
    notifyListeners();
  }
}
