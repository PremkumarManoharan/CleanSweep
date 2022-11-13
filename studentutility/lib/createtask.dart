// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studentutility/DataLayer/firestore.dart';
import 'package:studentutility/mainHomePage.dart';

class CreateTask extends StatefulWidget {
  final String roomcode;
  const CreateTask({super.key, required this.roomcode});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  TextEditingController taskName = new TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;
  final List<bool> _selectedtype = <bool>[true, false];
  final List<bool> _selectedrep = <bool>[true, false];

  List<Widget> types = <Widget>[
    Text('Date'),
    Text('Days'),
  ];
  List<Widget> repeat = <Widget>[
    Text('Repeat'),
    Text('Do not Repeat'),
  ];
  List<String> days = <String>[
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thurday",
    "Friday",
    "Saturday",
    "Sunday"
  ];
  List<String> dropdownValue = <String>[
    "Select Person",
    "Select Person",
    "Select Person",
    "Select Person",
    "Select Person",
    "Select Person",
    "Select Person"
  ];
  bool vertical = false;
  bool vertical1 = false;
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print(user?.uid);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: TextField(
              controller: taskName,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.white)),
                  hintText: 'Enter Task Name',
                  hintStyle: TextStyle(
                    color: Colors.white,
                  )),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ToggleButtons(
            direction: vertical ? Axis.vertical : Axis.horizontal,
            onPressed: (int index) {
              setState(() {
                // The button that is tapped is set to true, and the others to false.
                for (int i = 0; i < _selectedtype.length; i++) {
                  _selectedtype[i] = i == index;
                }
              });
            },
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            selectedBorderColor: Colors.red[700],
            selectedColor: Colors.white,
            fillColor: Colors.red[200],
            color: Colors.red[400],
            constraints: const BoxConstraints(
              minHeight: 40.0,
              minWidth: 80.0,
            ),
            isSelected: _selectedtype,
            children: types,
          ),
          SizedBox(
            height: 30,
          ),
          _selectedtype[0]
              ? Column(
                  children: [
                    Text(
                      "${selectedDate.toLocal()}".split(' ')[0],
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                      onPressed: () => _selectDate(context),
                      child: Text('Select date'),
                    ),
                  ],
                )
              : StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Rooms")
                      .doc(widget.roomcode)
                      .collection("Users")
                      .snapshots(),
                  builder: (context, snapshot) {
                    List<String> list = <String>["Select Person"];

                    for (int i = 0; i < snapshot.data!.docs.length; i++) {
                      list.add(snapshot.data!.docs[i]["name"]);
                    }
                    return Table(
                      border: TableBorder.all(),
                      columnWidths: const <int, TableColumnWidth>{
                        0: IntrinsicColumnWidth(),
                        1: FlexColumnWidth(),
                      },
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: <TableRow>[
                        for (int i = 0; i < 7; i++)
                          TableRow(
                            children: <Widget>[
                              Text(days[i],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: 'Nunito')),
                              TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.top,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 25.0),
                                  child: DropdownButton<String>(
                                    value: dropdownValue[i],
                                    icon: const Icon(Icons.arrow_downward),
                                    elevation: 16,
                                    style: const TextStyle(
                                        color: Colors.deepPurple),
                                    onChanged: (value) {
                                      print(value);
                                      // This is called when the user selects an item.
                                      setState(() {
                                        dropdownValue[i] = value!;
                                      });
                                    },
                                    items: list.map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    );
                  }),
          SizedBox(
            height: 20,
          ),
          ToggleButtons(
            direction: vertical1 ? Axis.vertical : Axis.horizontal,
            onPressed: (int index) {
              setState(() {
                // The button that is tapped is set to true, and the others to false.
                for (int i = 0; i < _selectedrep.length; i++) {
                  _selectedrep[i] = i == index;
                }
              });
            },
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            selectedBorderColor: Colors.red[700],
            selectedColor: Colors.white,
            fillColor: Colors.red[200],
            color: Colors.red[400],
            constraints: const BoxConstraints(
              minHeight: 40.0,
              minWidth: 80.0,
            ),
            isSelected: _selectedrep,
            children: repeat,
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: (() => {
                  for (int i = 0; i < dropdownValue.length; i++)
                    {
                      DataLayer.createTask(taskName.text, dropdownValue[i],
                          user!.uid, _selectedrep[0], widget.roomcode, days[i]),
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Home(roomcode: widget.roomcode),
                      ))
                    }
                }),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("Create"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
