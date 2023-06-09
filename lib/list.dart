import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:todo/edit.dart';
import 'package:todo/home.dart';
import 'connect.dart';
class list extends StatefulWidget {
  const list({Key? key}) : super(key: key);

  @override
  State<list> createState() => _listState();
}

class _listState extends State<list> {
  Future<void> _handleRefresh() async {
    // Perform your refresh operation here, such as fetching new data

    // Simulate a delay for demonstration purposes
    await Future.delayed(const Duration(seconds: 2));

    // Update your data or perform any other action

    // Call setState() to notify Flutter that the data has changed
    setState(() {
      // Update your data here
    });
  }//
  var uid;
  var flag=0;
  Future<dynamic>getdata() async {
    var responce = await get(Uri.parse("${con.utl}read.php"));
    print(responce.body);
    if (jsonDecode(responce.body)[0]['result'] == 'success') {
      flag = 1;
      return jsonDecode(responce.body);
    }
    else
      flag = 0;
    Text('No Data');
  }
  Future<dynamic>delete() async {
    var data={'id':uid};
    var responce = await post(Uri.parse("${con.utl}del.php"),body:data);
    if (jsonDecode(responce.body)['result'] == 'success') {
      // return jsonDecode(responce.body);
    }
    else
      const Center(
        child: CircularProgressIndicator(),
      );
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>home()));
            }, icon: Icon(Icons.add))
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/img.png'),fit: BoxFit.cover)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Lists To Do',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 25,left: 15,right: 15),
                //   child: TextField(
                //     decoration: InputDecoration(
                //       enabledBorder: OutlineInputBorder(
                //
                //       ),
                //       focusedBorder: OutlineInputBorder(),
                //       hintText: 'Add New Task',
                //       suffixIcon: IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.plus_app_fill,color: Colors.blueGrey,)
                //     ),
                //   )
                //   ),
                // ),
                // SizedBox(height: 25,),
                // Center(child: Text('Tasks',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                // SizedBox(height: 15,),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 600,
                    child: FutureBuilder(
                      future: getdata(),
                      builder: (context, snapshot) {
                        if(snapshot.hasError){
                          print(snapshot.error);
                        }
                        if(!snapshot.hasData || snapshot.data.length==0)
                          {
                            const Center(
                              child: Text('no data found'),
                            );
                          }
                        return flag==1?RefreshIndicator(
                          onRefresh: _handleRefresh,
                          child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context,index){
                            return Card(
                              elevation: 5,
                              child: Container(
                                height: 150,
                                color: Colors.white60,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('${snapshot.data[index]['action']}',style: TextStyle(fontWeight: FontWeight.bold),),
                                      SizedBox(height: 10,),

                                      Text('${snapshot.data[index]['time']}'),
                                      SizedBox(height: 10,),
                                      Row(
                                        children: [
                                          IconButton(onPressed: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>edit(
                                                task: snapshot.data[index]['action'], time: snapshot.data[index]['time'],
                                                id: snapshot.data[index]['id'])));
                                          }, icon: Icon(Icons.edit_note),

                                          ),
                                          IconButton(onPressed: (){
                                            uid=snapshot.data[index]['id'];
                                            setState(() {
                                              delete();
                                            });
                                          }, icon: Icon(CupertinoIcons.delete),)
                                        ],
                                      )


                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
    ),
    ):Center(child: Text('no data found',style: TextStyle(fontSize: 15),),);

    }
                    ),
                  ) )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
