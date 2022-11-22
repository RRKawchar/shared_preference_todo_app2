import 'package:flutter/material.dart';
import 'package:todo_app_with_shared_preferences/constants.dart';
import 'package:todo_app_with_shared_preferences/model/todo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List todos=[
    Todo(id: 1, title: "First todo", description: "Test Description", status: true),
    Todo(id: 1, title: "Second todo", description: "Test Description", status: false),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor,
      appBar: AppBar(
        backgroundColor: appColor,
        title:const Text(appBarTitle),
        centerTitle: true,
      ),
      body:ListView.builder(
          itemCount: todos.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context,index){
           return Card(
             elevation: 8.0,
             margin:const EdgeInsets.symmetric(horizontal: 10.0,vertical: 6.0),
             child: Container(
               decoration: const BoxDecoration(
                 color: color1
               ),
               child: InkWell(
                 child:makeListTile(todos[index], index)


               ),
             ),
           );

          }

      ) ,
    );
  }

  Widget makeListTile(Todo todo,index){

    return ListTile(
      contentPadding:const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      leading: Container(
        padding:const EdgeInsets.only(right: 12.0),
        decoration:const BoxDecoration(
          border: Border(
            right: BorderSide(width: 1.0,color: Colors.white24),
          ),
        ),
        child: CircleAvatar(
          backgroundColor: Colors.black26,
          child: Text("${index+1}"),
        ),

      ),
      title:Row(
        children: [

          Expanded(child: Text(todo.title,style: style1,overflow: TextOverflow.ellipsis,maxLines: 1)),
          const SizedBox(width: 10),
          todo.status?
             const Icon(Icons.verified,color: Colors.greenAccent,):Container()
        ],
      ),
      subtitle: Wrap(
        children: [
          Expanded(
            child: Text(todo.description,overflow: TextOverflow.clip,maxLines: 1,
            style: style2,),
          )
        ],
      ),
      trailing: InkWell(
        onTap: (){


        },
        child:const Icon(Icons.delete,color: Colors.white,size: 30.0,),
      ),
    );
  }
}
