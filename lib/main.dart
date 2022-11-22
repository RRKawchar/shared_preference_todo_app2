import 'package:flutter/material.dart';
import 'package:todo_app_with_shared_preferences/screens/home_screen.dart';

void main(){


  runApp(MyApp());
}
class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context){

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Todo app",
      home: HomeScreen(),

    );
  }
}