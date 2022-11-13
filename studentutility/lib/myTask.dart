// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Task extends StatefulWidget {
  final String roomcode;
  const Task({super.key,required this.roomcode});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  User? user = FirebaseAuth.instance.currentUser;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Tasks")
            .doc(widget.roomcode)
            .collection("Tasks")
            .where("AssignedTo" ,isEqualTo: user!.displayName)
            .snapshots(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: ListTile(
                      title: Text(snapshot.data!.docs[index].get("TaskName"), style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontFamily: 'Nunito'),),
                      subtitle: Text("Assigne to " +
                          snapshot.data!.docs[index].get("AssignedTo"),style: TextStyle(
                                        
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontFamily: 'Nunito'),),
                                        trailing:  Text("due by " +
                          snapshot.data!.docs[index].get("day"),style: TextStyle(
                                        
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontFamily: 'Nunito'),),
                    ),
                  ),
                  SizedBox(height: 20,)
                ],
              );
            },
          );
        },
      ),
    );
  }
}
