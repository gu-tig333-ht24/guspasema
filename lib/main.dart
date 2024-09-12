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

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("TIG333 TODO")),
        body: Column(children: [
          _item("Write a book"),
          _item("Do homework"),
        ]));
  }

  Widget _item(String task) {
    return Row(
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
    );
  }
}
