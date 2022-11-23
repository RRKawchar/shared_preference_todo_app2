import 'package:flutter/material.dart';
import 'package:todo_app_with_shared_preferences/constants.dart';

class buildTitleContainer extends StatelessWidget {
  buildTitleContainer(
      {Key? key, required this.controller, required this.onChange,required this.labelText,this.maxLines})
      : super(key: key);

  final TextEditingController controller;
  final void Function(String) onChange;
  int? maxLines;
  String labelText;



  @override
  Widget build(BuildContext context) {
    return Container(
      child: colorOverride(
        TextField(
          maxLines: maxLines,
          onChanged: onChange,
          style: style2,
          decoration: InputDecoration(
              labelStyle: style2,
              labelText: labelText,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(color: Colors.white))),
          controller: controller,
        ),
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