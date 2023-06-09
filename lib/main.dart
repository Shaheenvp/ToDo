import 'package:flutter/material.dart';
import 'package:todo/list.dart';

import 'home.dart';


void main()
{
  runApp(MyApp());

}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: list(),
      debugShowCheckedModeBanner: false,
    );
  }
}