// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:todo_app_with_shared_preferences/constants.dart';
import 'package:todo_app_with_shared_preferences/model/todo.dart';
import 'package:todo_app_with_shared_preferences/widget/build_title_container.dart';

class TodoViews extends StatefulWidget {
  final Todo todo;
  const TodoViews({Key? key, required this.todo}) : super(key: key);

  @override
  State<TodoViews> createState() => _TodoViewsState();
}

class _TodoViewsState extends State<TodoViews> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.todo != null) {
      titleController.text = widget.todo.title!;
      descriptionController.text = widget.todo.description!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor,
      appBar: AppBar(
        elevation: 10,
        backgroundColor: appColor,
        title: const Text(todoView),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              buildTitleContainer(
                controller: titleController,
                onChange: (data) {
                  widget.todo.title = data;
                },
                labelText: "Title",
              ),
              const SizedBox(height: 25),
              buildTitleContainer(
                controller: descriptionController,
                onChange: (data) {
                  widget.todo.description = data;
                },
                labelText: "Description",
                maxLines: 5,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 55.0,
        child: BottomAppBar(
          color: appColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildInkWell(context),
              const VerticalDivider(
                color: Colors.white,
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context, widget.todo);
                },
                icon: const Icon(
                  Icons.save,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  InkWell buildInkWell(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text("Alert"),
                  content: Text(
                      "Mark this todo as ${widget.todo.status ? ' Not done' : ' done'} "),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("No")),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          widget.todo.status = !widget.todo.status;
                        });

                        Navigator.pop(context);
                      },
                      child: const Text("Yes"),
                    )
                  ],
                ));
      },
      child: Text(
        widget.todo.status ? "Mark as not done" : "Mark as done",
        style: style2,
      ),
    );
  }

  Widget colorOverride(Widget child) {
    return Theme(
        data: ThemeData(
            primaryColor: Colors.white,
            hintColor: Colors.white,
            backgroundColor: Colors.white),
        child: child);
  }
}
