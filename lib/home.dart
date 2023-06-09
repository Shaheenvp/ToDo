import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:todo/list.dart';
import 'connect.dart';
class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  var actionctrl=TextEditingController();
  var timectrl=TextEditingController();
Future <void> senddata() async{
  var data= {
    'action' : actionctrl.text,
    'time' : timectrl.text,
  };

  var response=await post(Uri.parse("${con.utl}add.php"),body: data);
  print(response.body);
  if (jsonDecode(response.body)['result']=='success')
    {
     setState(() {
       Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context)=>list()),(Route <dynamic> route )=>false);     });
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/img.png'),fit: BoxFit.cover)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Padding(

              padding: const EdgeInsets.only(top: 150),
              child: Column(
                children: [
                  TextField(
                    controller: actionctrl,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      label: Text('Task'),

                    ),
                  ),
                  SizedBox(height: 15,),

                  TextField(
                    controller: timectrl,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      label: Text('Discription'),
                    ),
                  ),
                  SizedBox(height: 15,),
                  Container(
                    height: 35,
                      width: 80,
                      child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey,),onPressed: (){
                        senddata();
                        print(actionctrl);
                        print(timectrl);
                      }, child: Text('Add')))

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
