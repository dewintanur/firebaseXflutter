import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addUserDetails(Map<String, dynamic> userInfoMap) async {
    return await FirebaseFirestore.instance
        .collection("myCafe")
        .doc()
        .set(userInfoMap);
  }

  Future<QuerySnapshot> getthisUserInfo(String name)async{
    return await FirebaseFirestore.instance.collection("myCafe")
          .where("Cafe", isEqualTo: name)
          .get();
  }
  // DocumentReference documentReference = FirebaseFirestore.instance.collection("myCafe").doc(firstname)

  Future UpdateUserData(String age, String id) async {
    return await FirebaseFirestore.instance
        .collection("myCafe")
        .doc(id)
        .update({"Rate": age});
  }

  Future DeleteUserData(String id) async {
    return await FirebaseFirestore.instance
        .collection("myCafe")
        .doc(id)
        .delete();
  }
}
