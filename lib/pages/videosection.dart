import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smile_care_connect/helpful/Maindrawer.dart';

import 'package:smile_care_connect/models/userModel.dart';

class VideoSec extends StatefulWidget {
  final UserModel userModel;
  final User firebaseuser;
  const VideoSec({super.key, required this.userModel, required this.firebaseuser});

  @override
  State<VideoSec> createState() => _VideoSecState();
}
int _selected=2;
class _VideoSecState extends State<VideoSec> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(firebaseuser: widget.firebaseuser, userModel: widget.userModel,),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Video Section",
        style: TextStyle(fontSize: 25),
        ),
        backgroundColor: Colors.blue,
      ),
      body:
      SafeArea(child:Container() ,)
    );
  }
}