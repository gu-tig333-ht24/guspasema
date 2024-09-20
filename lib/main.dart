import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class MyState extends ChangeNotifier {
  final List<Task> _tasks = [];
  String _textFieldValue = "";
  int _taskId = 0;
  Task _task = Task("temp", true, 0);

  List<Task> _listDone = [];
  List<Task> _listunDone = [];

  List get tasks => _tasks;
  List get listDone => _listDone;
  List get listunDone => _listunDone;
  String get textFieldValue => _textFieldValue;
  int get taskId => _taskId;
  Task get task => _task;

  void filterLists() {
    _listDone = _tasks.where((i) => i.isComplete = true).toList();
    _listunDone = _tasks.where((i) => i.isComplete = false).toList();
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
      _tasks[i]._taskId = i;
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
    tasks.removeAt(task._taskId);
    notifyListeners();
  }
}

void main() {
  MyState state = MyState();

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

class Task {
  String taskName = "no name";
  bool? isComplete = true;
  int _taskId = 0;

  int get id => _taskId;

  Task(this.taskName, this.isComplete, this._taskId) {
    _taskId++;
  } //constructor för task

  void decreaseId() {
    _taskId--;
  }
}

class MyHome extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var tasks = context.watch<MyState>().tasks;
    var filteredList = context.watch<MyState>().tasks;
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
                  context.read<MyState>().filterLists();
                  filteredList = context.read<MyState>().getWholeList();
                } else if (result == 1) {
                  context.read<MyState>().filterLists();
                  filteredList = context.read<MyState>().getListDone();
                  //print(context.read<MyState>()._tasks);
                  print(filteredList);
                } else if (result == 2) {
                  context.read<MyState>().filterLists();
                  filteredList = context.read<MyState>().GetlistunDone();
                }
              }),
        ],
      ),
      body: Consumer<MyState>(
        builder: (context, state, _) => ListView(
          children: filteredList
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
  var tasks = context.watch<MyState>().tasks;

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
                value: state._tasks[task.id].isComplete,
                onChanged: (isComplete) {
                  context.read<MyState>().setTask(task);
                  context.read<MyState>().changeValue(task.id, isComplete);
                }),
          ),
        ),
        Expanded(
          child: Consumer<MyState>(
            builder: (context, state, _) => Text(
              task.taskName,
              style: state._tasks[task.id].isComplete!
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
            onPressed: () {
              //context.read<MyState>().removeFromList(task.id);
              context.read<MyState>().removeAtList(task);
              context.read<MyState>().reassignId();
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
              onPressed: () {
                context.read<MyState>().addToList(
                    // Task(context.read<MyState>().textFieldValue, false));

                    new Task(fieldText, false, context.read<MyState>().taskId));
                context.read<MyState>().increamentId();
                context.read<MyState>().reassignId();
              }, //knappen gör inget än
            )
          ],
        ),
      ),
    );
  }
}
