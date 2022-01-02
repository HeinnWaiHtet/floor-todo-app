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
  late final database;
  late TodoDao todoDao;
  final key = GlobalKey<FormState>();
  int lastId = 1;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    getConnection();
  }

  getConnection() async{
    database = await $FloorTodoDatabase.databaseBuilder("todo_databse.db").build();
    setState(() {
      todoDao = database.todoDao;
    });
  }

  add(int id, String task){
    this.todoDao.insertTask(Todo(id, task));
  }

  getLastId() async{
    Todo? todo = await this.todoDao.findTodoLast();
    if(todo != null){
      setState(() {
      this.lastId = todo.id + 1;
    });
    }
  }

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
                  fontSize: 21)
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
                  await this.getLastId();
                  this.add(this.lastId, task);
                  controller.text = "";
                }
              },
            ),
          ),

          Expanded(
            child: StreamBuilder<List<Todo>>(
              stream: this.todoDao.findAllTodo(),
              builder: (context, AsyncSnapshot snapshot){
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context,index){
                    Todo todo = snapshot.data[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10)
                          )
                        ),
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                            child: Text(
                            todo.task,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 21,
                              color: Colors.orange
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: (){

                            },
                            icon: Icon(Icons.edit),
                            color: Colors.red,
                          ),
                          IconButton(
                            onPressed: (){
                              setState(() {
                                this.todoDao.deleteById(todo.id);
                              });
                            },
                            icon: Icon(Icons.delete),
                            color: Colors.red,
                          ),
                        ],
                    ),
                  );
                });
              },
            )
          ),
      ],
    );
  }
}