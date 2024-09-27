// ignore: non_constant_identifier_names

// ignore_for_file: file_names

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'model.dart';
import 'package:flutter/material.dart';

void Dostuff() async {}
const String ENDPOINT = 'https://todoapp-api.apps.k8s.gu.se';

Future<List<Task>> getTasks() async {
  print('Making a request to Api');
  http.Response response = await http.get(
      Uri.parse('$ENDPOINT/todos?key=60175dcf-1ee6-4f12-9544-c0c253e0d60c'));

  String body = response.body;
  //3print(body);
  // Map<String, dynamic> jsonResponse = jsonDecode(body);
  // List todosJson = jsonResponse['todos'];
  List tasksJson = jsonDecode(body);
  //print(todosJson.length);
  print('this is title');
  print('${tasksJson[1]['title']}');
  return tasksJson.map((json) => Task.fromJson(json)).toList();
}

Future<void> addTask(Task task) async {
  http.Response response = await http.post(
      Uri.parse('$ENDPOINT/todos?key=60175dcf-1ee6-4f12-9544-c0c253e0d60c'),
      headers: {"Content-Type": "applications/json"},
      body: jsonEncode(task.toJson()));
  var jsonData = response.body;
  var obj = jsonDecode(jsonData);
  print('this is add response');
  //print('${obj['done']}');
  print(response.body);
  print('title');
  print('done');
}

Future<void> deleteTask(task) async {
  final response = await http.delete(
    Uri.parse(
        'https://todoapp-api.apps.k8s.gu.se/todos/${task.id}?key=60175dcf-1ee6-4f12-9544-c0c253e0d60c'),
  );
  print('trying to delete');
}

class Internetfetcher {
  static Future<String> FetchIp() async {
    //http.Response response = await http.get('https://api.myip.com/');
    http.Response response = await http.get(Uri.parse('$ENDPOINT/register'));
    var jsonData = response.body;
    var obj = jsonDecode(jsonData);
    return '${obj['id']} i landet ${obj['title']}';
  }
}
