import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: " flutter start",
      home: const MyHomePage(),
    );
  }
}

class Task {
  String taskName;
  bool isComplete;

  Task(this.taskName, this.isComplete); //constructor för task
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //skapar en lista med tasks och väljer deras defualtvärden
    List<Task> tasks = [
      Task("Do HomeWork", false),
      Task("Write a book", false),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text("TIG333 TODO")),
      body: ListView(
        children: tasks
            .map((task) => _item(context, task.taskName, task.isComplete))
            .toList(), //map är en iterator som returerar en lista
      ),
    );
  }

  Widget _item(BuildContext context, task, bool isComplete) {
    return GestureDetector(
      onTap: () {
        //när du klickar på raden så kommer du navigeras till TaskInfo vyn
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => TaskInfo()));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: Checkbox(value: false, onChanged: (bool? value) {}),
          ),
          Expanded(
            child: Text(
              task,
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: Icon(Icons.close),
          )
        ],
      ),
    );
  }
}

class TaskInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
