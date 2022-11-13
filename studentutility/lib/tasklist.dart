// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:studentutility/drawer.dart';

class TaskList extends StatefulWidget {
  final String roomcode;
  const TaskList({super.key, required this.roomcode});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    print(widget.roomcode);
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.black,
      title: Text("CleanSweep"),
      iconTheme: IconThemeData(color: Colors.white),
    ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(height: 40,),
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Rooms")
                    .doc(widget.roomcode)
                    .collection("Users")
                    .snapshots(),
                builder: (context, snapshot) {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              title: Text(snapshot.data!.docs[index]["name"],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Nunito')),
                              subtitle: Text("Status: Sleeping",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Nunito')),
                              trailing: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color.fromARGB(255, 221, 120, 113),
                                  ),
                                  child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Text(
                                        "Contact",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Nunito'),
                                      ))),
                            ),
                            SizedBox(height: 20,)
                          ],
                        );
                      });
                }),
          ),
        ],
      ),
    );
  }
}
 