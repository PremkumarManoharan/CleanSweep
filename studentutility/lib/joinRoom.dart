// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studentutility/DataLayer/firestore.dart';
import 'package:studentutility/mainHomePage.dart';
import 'package:studentutility/tasklist.dart';

class JoinRoom extends StatefulWidget {
  const JoinRoom({super.key});

  @override
  State<JoinRoom> createState() => _JoinRoomState();
}

class _JoinRoomState extends State<JoinRoom> {
  TextEditingController roomCode = new TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
            child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: roomCode,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 3, color: Colors.white)),
                        hintText: 'Enter Room Code',
                        hintStyle: TextStyle(
                          color: Colors.white,
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 40, right: 40),
                      child: Text(
                          "Enter Room code to join the a existing room",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Nunito'))),
                  SizedBox(
                    height: 80,
                  ),
                  InkWell(
                    onTap: () {
                      DataLayer().joinRoom(
                          roomCode.text, user!.uid, user?.displayName);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Home(roomcode: roomCode.text),
                          ));
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              "Join",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Nunito'),
                            ))),
                  )
                ]))
      ]),
    );
  }
}
