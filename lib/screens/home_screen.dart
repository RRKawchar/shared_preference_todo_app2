import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_with_shared_preferences/constants.dart';
import 'package:todo_app_with_shared_preferences/model/todo.dart';
import 'package:todo_app_with_shared_preferences/screens/todo_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    SharedPreferences? pref;
  List todos = [];

  setupTodo() async {
    pref=await SharedPreferences.getInstance();
    String? stringTodo= pref!.getString("todo");

    List todoList=jsonDecode(stringTodo!);

    for(var todo in todoList){
      setState(() {
        todos.add(Todo(status: false).fromJson(todo));
      });
    }
  }

  saveTodo(){

    List items=todos.map((e) => e.toJson()).toList();
    pref!.setString('todo', jsonEncode(items));
  }

  @override
  void initState() {
    setupTodo();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor,
      appBar: AppBar(
        backgroundColor: appColor,
        title: const Text(appBarTitle),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: todos.length,
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Card(
              elevation: 8.0,
              margin:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: Container(
                decoration: const BoxDecoration(color: color1),
                child: InkWell(
                    onTap: () async {
                      Todo t = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  TodoViews(todo: todos[index])));

                      if (t != null) {
                        setState(() {
                          todos[index] = t;
                        });
                        saveTodo();
                      }
                    },
                    child: makeListTile(todos[index], index)),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          addTodo();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  addTodo() async {
    int id = Random().nextInt(30);
    Todo t = Todo(id: id, title: "", description: "", status: false);

    Todo returnTodo = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => TodoViews(todo: t)));

    if (returnTodo != null) {
      setState(() {
        todos.add(returnTodo);
      });
      saveTodo();

    }
  }

  Widget makeListTile(Todo todo, index) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      leading: Container(
        padding: const EdgeInsets.only(right: 12.0),
        decoration: const BoxDecoration(
          border: Border(
            right: BorderSide(width: 1.0, color: Colors.white24),
          ),
        ),
        child: CircleAvatar(
          backgroundColor: Colors.black26,
          child: Text("${index + 1}"),
        ),
      ),
      title: Row(
        children: [
          Expanded(
              child: Text(todo.title.toString(),
                  style: style1, overflow: TextOverflow.ellipsis, maxLines: 2)),
          const SizedBox(width: 10),
          todo.status
              ? const Icon(
                  Icons.verified,
                  color: Colors.greenAccent,
                )
              : Container()
        ],
      ),
      subtitle: Wrap(
        children: [
          Text(
            todo.description.toString(),
            overflow: TextOverflow.clip,
            maxLines: 1,
            style: style2,
          )
        ],
      ),
      trailing: InkWell(
        onTap: () {
          delete(todo);
        },
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 30.0,
        ),
      ),
    );
  }

  delete(Todo todo) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Alert"),
              content: const Text("Are you sure you want to delete"),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("No")),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        todos.remove(todo);
                      });

                      Navigator.pop(context);
                      saveTodo();
                    },
                    child: const Text("Yes"))
              ],
            ));
  }
}
