import 'package:flutter/material.dart';
import 'package:studentutility/createnewroom.dart';
import 'package:studentutility/createtask.dart';
import 'package:studentutility/joinRoom.dart';
import 'package:studentutility/loginpage.dart';
import 'package:studentutility/mainHomePage.dart';
import 'package:studentutility/roomcode.dart';
import 'package:studentutility/tasklist.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        '/createNewRoom': (context) => CreateNewRoom(),
        
        '/JoinExistingRoom': (context) => JoinRoom(),
        '/Login': (context) => LoginPage(),
      
       
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          inputDecorationTheme: const InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 3, color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 3, color: Colors.white),
        ),
      )),
      home: LoginPage(),
    );
  }
}
