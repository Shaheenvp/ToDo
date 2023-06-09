import 'dart:convert';
import 'package:todo/list.dart';

import 'connect.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
class edit extends StatefulWidget {
  edit( {Key? key,required this.task,required
  this.time,required this.id}) : super(key: key);
  var task,time,id;
  @override
  State<edit> createState() => _editState();
}

class _editState extends State<edit> {
  var taskctrl=TextEditingController();
  var timectrl=TextEditingController();
  Future <void>senddata() async{
    var data={
      'action':taskctrl.text,
      'time':timectrl.text,
      'id':widget.id
    };
    var response=await post(Uri.parse("${con.utl}update.php"),
        body: data);
    print(response.body);
    if(jsonDecode(response.body)
    ['result']=='Success'){
      setState(() {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> list()),
                (Route<dynamic>route) => false);
      });
    }
    setState(() {
      ScaffoldMessenger.of(context).
      showSnackBar(SnackBar(content: Text('Updated')));
    });
  }
  @override
  void initState(){
    super.initState();
    print(widget.task);
    print(widget.time);
    print(widget.id);
    taskctrl.text=widget.task;
    timectrl.text=widget.time;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
            children: [
              TextFormField(
                controller: taskctrl,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    hintText: 'task'
                ),
              ),
              TextFormField(
                controller: timectrl,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    hintText: 'time'
                ),
              ),
              OutlinedButton(onPressed: (){
                if(taskctrl.text.isNotEmpty&& timectrl.text.isNotEmpty){
                  print(taskctrl.text);
                  print(timectrl.text);
                  setState(() {

                  });
                  senddata();
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>list()));
                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('All field required')));
                }
              },
                  child: Text('Update'))
            ],
            ),
        );
    }
}
