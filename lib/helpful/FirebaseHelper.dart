import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smile_care_connect/models/userModel.dart';

class Firebasehelper{
  static Future<UserModel?>  getUserModelById(String uid)async
  {
UserModel? usermodel;
DocumentSnapshot docsnap = await FirebaseFirestore.instance.collection("users").doc(uid).get();
  if(docsnap.data()!= null)
  {
    usermodel =UserModel.fromMap(docsnap.data() as Map<String,dynamic>);
  }
  return usermodel;
  }
}