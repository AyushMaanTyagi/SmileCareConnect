import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smile_care_connect/helpful/Maindrawer.dart';
import 'package:smile_care_connect/models/userModel.dart';

class Doctorlist extends StatefulWidget {
 final UserModel userModel;
  final User firebaseuser;
   const Doctorlist({super.key, required this.userModel,required this.firebaseuser});

  @override
  State<Doctorlist> createState() => _DoctorlistState();
}

class _DoctorlistState extends State<Doctorlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(firebaseuser: widget.firebaseuser, userModel: widget.userModel,),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Doctors Connect",
        style: TextStyle(fontSize: 25),
        ),
        backgroundColor: Colors.blue,
        
      ),
      body:
      SafeArea(
        child:Container(
        child: const Column(
          children: [
            Card(
              
            )
          ],
        ),

      ) ,)
    );
  }
}