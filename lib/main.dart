import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'MyState.dart';
import 'model.dart';
import 'api.dart';

void main() {
  MyState state = MyState();

  state.fetchTasks();
  runApp(
    ChangeNotifierProvider(
      create: (context) => state,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: " flutter start",
      home: MyHome(),
    );
  }
}

class MyHome extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    var tasks = context.watch<MyState>().tasks;
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
                      value: 0,
                      child: Text("all"),
                    ),
                    PopupMenuItem(
                      value: 1,
                      child: Text("done"),
                    ),
                    PopupMenuItem(
                      value: 2,
                      child: Text("undone"),
                    ),
                  ],
              onSelected: (result) {
                if (result == 0) {
                  context.read<MyState>().filterLists(null);
                  //print(context.read<MyState>().filteredTasks);
                  //filteredList = context.read<MyState>().getWholeList();
                } else if (result == 1) {
                  context.read<MyState>().filterLists(true);
                  //filteredList = context.read<MyState>().getListDone();
                  //print(context.read<MyState>().filteredTasks);
                  //print(filteredList);
                } else if (result == 2) {
                  context.read<MyState>().filterLists(false);
                  //print(context.read<MyState>().filteredTasks);
                  //filteredList = context.read<MyState>().GetlistunDone();
                }
              }),
        ],
      ),

      body: Consumer<MyState>(
        builder: (context, state, _) => ListView(
          //context.watch<MyState>().filteredTasks.map((task) => _item(context, task)).toList(),
          children: tasks
              .map((task) => _item(context, task))
              .toList(), //map är en iterator som returerar en lista
        ),
      ), //när du klickar på knappen så kommer du navigeras till AddTask vyn
      //den gör detta via en stack, och vyn pushas till toppen av stacken med funktionen push
      floatingActionButton: RawMaterialButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTask(),
            ),
          );
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

Widget _item(BuildContext context, Task task) {
  return GestureDetector(
    //gesture detect används eftersom det inte är en knapp utan bara en lista med items
    onTap: () {},
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
          child: Consumer<MyState>(
            builder: (context, state, _) => Checkbox(
                tristate: false,
                activeColor: Colors.black,
                value: task.done,
                //value: state.tasks[task.].isComplete,
                onChanged: (isComplete) {
                  context.read<MyState>().changeValue(task, isComplete);
                }),
          ),
        ),
        Expanded(
          child: Consumer<MyState>(
            builder: (context, state, _) => Text(
              task.title,
              style: task.done!
                  ? TextStyle(
                      decoration: TextDecoration.lineThrough, fontSize: 24)
                  : TextStyle(fontSize: 24),
              textAlign: TextAlign.left,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(15),
          // child: Icon(Icons.close),
          child: FloatingActionButton(
            heroTag: null,
            elevation: 0,
            onPressed: () async {
              //context.read<MyState>().removeFromList(task.id);
              //context.read<MyState>().removeAtList(task);
              await deleteTask(task);
              context.read<MyState>().fetchTasks();
              //task.decreaseId();
              //context.read<MyState>().decreaseId();
            },
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
            splashColor: const Color.fromARGB(255, 202, 202, 202),
            child: Icon(Icons.close),
          ),
        ),
      ],
    ),
  );
}

//add task vyn, man kommer hit genom att trycka pluset i homepage vyn
class AddTask extends StatelessWidget {
  String fieldText = "No name";
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
                      hintStyle:
                          TextStyle(color: Colors.black.withOpacity(0.3)),
                      hintText: "What are you going to do?"),
                  onChanged: (text) {
                    context.read<MyState>().updateTextFieldValue(text);
                    fieldText = text;
                  }),
            ),
            FloatingActionButton.extended(
              heroTag: "addbutton1",
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
              onPressed: () async {
                // var result = await fetchsomeStuff();
                //Dostuff();
                //getTasks();
                Task task = Task(fieldText, false);
                //print(task.title);
                //print(jsonEncode(task.toJson()));
                await addTask(task);
                context.read<MyState>().fetchTasks();
                //context.read<MyState>().addToList(
                // Task(context.read<MyState>().textFieldValue, false));

                //context.read<MyState>().increamentId();
                //context.read<MyState>().reassignId();
              }, //knappen gör inget än
            )
          ],
        ),
      ),
    );
  }
}
