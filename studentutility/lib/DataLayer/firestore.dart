import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class DataLayer {
  int createRoom(var code, String name, String uid, String? username) {
    FirebaseFirestore.instance
        .collection('Rooms')
        .doc(code.toString())
        .set({"room_code": code.toString(), "room_name": name, "UID": uid});
    FirebaseFirestore.instance
        .collection('Rooms')
        .doc(code.toString())
        .collection("Users")
        .doc(uid)
        .set({"name": username});
    FirebaseFirestore.instance
        .collection("Users")
        .doc(uid)
        .set({"room_id": code});

    return 1;
  }

  static Future<String> newUser(String uid) async {
    String result = " ";
    var userRef = await FirebaseFirestore.instance
        .collection("Users")
        .doc(uid)
        .get()
        .then((docSnapshot) => {
              if (docSnapshot.exists)
                {
                  print("here"),
                  result = docSnapshot.get("room_id").toString(),
                  print(result)
                }
            });
    return result;
  }

  static void createTask(String name, String assignedTo, String CreatedBy,
      bool isRepeated, String roomId,String day) {
    FirebaseFirestore.instance
        .collection("Tasks")
        .doc(roomId)
        .collection("Tasks")
        .add({
      "AssignedTo": assignedTo,
      "CreatedAt": DateTime.now(),
      "CreateBy": CreatedBy,
      "TaskName": name,
      "isRepeated": isRepeated,
      "day":day
    });
  }

  void joinRoom(var code, String uid, String? name) {
    FirebaseFirestore.instance
        .collection("Rooms")
        .doc(code.toString())
        .collection("Users")
        .doc(uid)
        .set({"name": name});
    FirebaseFirestore.instance
        .collection("Users")
        .doc(uid)
        .set({"room_id": code});
  }
}
