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
      Task("Do HomeWork", false),
      Task("Write a book", false),
      Task("Do HomeWork", false),
      Task("Write a book", false),
      Task("Do HomeWork", false),
      Task("Write a book", false),
      Task("Do HomeWork", false),
      Task("Write a book", false),
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

      //när du klickar på knappen så kommer du navigeras till AddTask vyn
      //den gör detta via en stack, och vyn pushas till toppen av stacken med funktionen push
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddTask()));
      }),
    );
  }

  Widget _item(BuildContext context, task, bool isComplete) {
    return GestureDetector(
      onTap: () {},
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

class AddTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: TextField(
                decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.black.withOpacity(0.3)),
                    hintText: "What are you going to do?"),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {},
                ),
                Text("Add"),
              ],
            )
          ],
        ),
      ),
    );
  }
}
