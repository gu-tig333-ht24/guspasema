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
      Task("Do Homework", false),
      Task("Write a book", false),
      Task("Do Homework", false),
      Task("Write a book", false),
      Task("Do Homework", false),
      Task("Write a book", false),
      Task("Do Homework", false),
      Task("Write a book", false),
      Task("Do Homework", false),
      Task("Write a book", false),
      Task("Do Homework", false),
      Task("Write a book", false),
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "TIG333 TODO",
          style: TextStyle(fontSize: 30),
        ),
        backgroundColor: const Color.fromARGB(255, 224, 224, 224),
        scrolledUnderElevation: 0,
        actions: [
          PopupMenuButton<int>(
            color: (Colors.white),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text("all"),
              ),
              PopupMenuItem(
                child: Text("done"),
              ),
              PopupMenuItem(
                child: Text("undone"),
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        children: tasks
            .map((task) => _item(context, task.taskName, task.isComplete))
            .toList(), //map är en iterator som returerar en lista
      ), //när du klickar på knappen så kommer du navigeras till AddTask vyn
      //den gör detta via en stack, och vyn pushas till toppen av stacken med funktionen push
      floatingActionButton: RawMaterialButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddTask()));
        },
        fillColor: const Color.fromARGB(255, 224, 224, 224),
        shape: CircleBorder(),
        child: Icon(
          Icons.add,
          size: 75,
          color: Colors.white,
        ),
      ),
    );
  }
}

Widget _item(BuildContext context, task, bool isComplete) {
  return GestureDetector(
    //gesture detect används eftersom det inte är en knapp utan bara en lista med items
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

//add task vyn, man kommer hit genom att trycka pluset i homepage vyn
class AddTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "TIG333 TODO",
          style: TextStyle(fontSize: 30),
        ),
        backgroundColor: const Color.fromARGB(255, 224, 224, 224),
        scrolledUnderElevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(15, 25, 15, 35),
              child: TextField(
                decoration: InputDecoration(
                    //dekorationer för textfältet
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(width: 2, color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.black),
                    ),
                    hintStyle: TextStyle(color: Colors.black.withOpacity(0.3)),
                    hintText: "What are you going to do?"),
              ),
            ),
            FloatingActionButton.extended(
              //extended gör att både en icon och text kan vara i knappen
              elevation: 0,
              label: Text("ADD",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              icon: Icon(
                Icons.add,
                size: 25,
              ),
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.black,
              splashColor: const Color.fromARGB(255, 202, 202, 202),
              onPressed: () {}, //knappen gör inget än
            )
          ],
        ),
      ),
    );
  }
}
