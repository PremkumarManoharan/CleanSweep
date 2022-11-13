// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:studentutility/mainHomePage.dart';
import 'package:studentutility/tasklist.dart';

class RoomCode extends StatefulWidget {
  final String roomcode;
  const RoomCode({super.key,required this.roomcode});

  @override
  State<RoomCode> createState() => _RoomCodeState();
}

class _RoomCodeState extends State<RoomCode> {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
            child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Text(
                    "Room Code",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Nunito'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child:  Text(widget.roomcode, style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Nunito')),
                    ),
                    
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 45, right: 45),
                      child: Text(
                          "Share this code with your roommates for them to join your room",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Nunito'))),
                  SizedBox(
                    height: 60,
                  ),
                  InkWell(
                    onTap: () => {
                     Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Home(roomcode:widget.roomcode ),
        )),
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              "Set Up Room",
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
