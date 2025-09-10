
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smile_care_connect/helpful/FirebaseHelper.dart';
import 'package:smile_care_connect/models/userModel.dart';
import 'package:smile_care_connect/pages/homepage.dart';
import 'package:smile_care_connect/pages/welcome.dart';

import 'firebase_options.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
   options: DefaultFirebaseOptions.currentPlatform,
 );
 User? currentUser=FirebaseAuth.instance.currentUser;
 if(currentUser==null)
 {
  log("current user null");
  runApp(const MyApp());
 }
  else
  {
  UserModel? userModel= await Firebasehelper.getUserModelById(currentUser.uid);
  if(userModel !=null)
  {
    log("current uder:${currentUser.uid}");
    runApp( MyAppLoggedIn(userModel:userModel , firebaseuser: currentUser,));
  }

  else
  {
    log("message");
    runApp(const MyApp());
  }

  }

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
     // home: const MyHomePage(title: 'Flutter Demo Home Page'),
     home: const Welcomepage(),
    );
  }
}

class MyAppLoggedIn extends StatelessWidget {
  final UserModel userModel;
  final User firebaseuser;
  const MyAppLoggedIn({super.key,required this.userModel,required this.firebaseuser});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Homepage(userModel: userModel, firebaseuser: firebaseuser),
    );
  }
}
