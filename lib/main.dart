import 'package:flutter/material.dart';
import 'package:todoapp/db/todo_dao.dart';
import 'package:todoapp/db/todo_database.dart';

import 'db/todo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.red),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Todo App"),
          ),
        body: MyHome(),
      ),
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({ Key? key }) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final key = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: key,
          child: Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              controller: controller,
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Task Must Enter";
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "Enter your Task",
                labelText: "Enter Task",
                labelStyle: TextStyle(
                  color: Colors.deepOrange,
                  fontSize: 28)
                ),
              style: TextStyle(
                fontSize: 18,
                color: Colors.black
              ),
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.red,
                primary: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10)
                  )
                )
              ),
              child: Text(
                "Save",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  ),
                ),
              onPressed: () async{
                if(key.currentState!.validate()){
                  String task = controller.text;
                  final databse = await $FloorTodoDatabase.databaseBuilder("todo_databse.db").build();
                  TodoDao todoDao = databse.todoDao;
                  todoDao.insertTask(Todo(1, task));

                }
              },
            ),
          ),
      ],
    );
  }
}