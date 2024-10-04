// ignore: non_constant_identifier_names

// ignore_for_file: file_names

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'model.dart';

const String ENDPOINT = 'https://todoapp-api.apps.k8s.gu.se';

Future<List<Task>> getTasks() async {
  print('Making a request to Api');
  http.Response response = await http.get(
      Uri.parse('$ENDPOINT/todos?key=60175dcf-1ee6-4f12-9544-c0c253e0d60c'));

  String body = response.body;
  List tasksJson = jsonDecode(body);

  return tasksJson.map((json) => Task.fromJson(json)).toList();
}

Future<void> addTask(Task task) async {
  http.Response response = await http.post(
      Uri.parse('$ENDPOINT/todos?key=60175dcf-1ee6-4f12-9544-c0c253e0d60c'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(task.toJson()));
  await getTasks();
}

Future<void> deleteTask(task) async {
  http.Response response = await http.delete(
    Uri.parse(
        'https://todoapp-api.apps.k8s.gu.se/todos/${task.id}?key=60175dcf-1ee6-4f12-9544-c0c253e0d60c'),
  );
  print('trying to delete');
  print('Status ${response.statusCode}');
  if (response.statusCode == 200) {
    print('successfully deleted');
  }
  await getTasks();
}

Future<void> updateTask(task) async {
  http.Response response = await http.put(
      Uri.parse(
          'https://todoapp-api.apps.k8s.gu.se/todos/${task.id}?key=60175dcf-1ee6-4f12-9544-c0c253e0d60c'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(task.toJson()));
  await getTasks();
}
