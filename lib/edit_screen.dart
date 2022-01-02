import 'package:flutter/material.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({ Key? key }) : super(key: key);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final key = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Task"),
        ),
        body: Column(
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
                "Update",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  ),
                ),
              onPressed: () async{
                if(key.currentState!.validate()){
                  
                }
              },
            ),
          ),
       ]),
      );
  }
}