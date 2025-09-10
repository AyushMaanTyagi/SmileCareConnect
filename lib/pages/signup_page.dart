//import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:smile_care_connect/models/userModel.dart';
import 'package:smile_care_connect/pages/homepage.dart';
import 'package:smile_care_connect/pages/login_page.dart';
import 'package:smile_care_connect/helpful/customTextfield.dart';

class SignupPage extends StatefulWidget {

  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController emailC =  TextEditingController();
  final  TextEditingController passwordC =  TextEditingController();
  final TextEditingController cpasswordC =  TextEditingController();
  final TextEditingController usernameC= TextEditingController();
  //final TextEditingController genderC=TextEditingController();
  final TextEditingController ageC=TextEditingController();
  final TextEditingController dobC=TextEditingController();
  final TextEditingController PhoneC=TextEditingController();
  String? gender;
  static List<String>item=["male","female","other"];

  void checkvalues()
  {
    String username=usernameC.text.trim();
    String email = emailC.text.trim();
    String password = passwordC.text.trim();
    String cpassword = cpasswordC.text.trim();
     //String gender = genderC.text.trim();
     String age = ageC.text.trim();
     String dob = dobC.text.trim();
      String phoneno = PhoneC.text.trim();

    if (email == "" || password == "" || cpassword == ""||username==""||gender==""||age==""||phoneno==""||dob=="") {
      print("please fill all the details..");
    } else if (cpassword != password) {
      print("password do not match");
    } else {
      //crrete useraccount using email and password
      createAccount(email,password,username,age,gender!,phoneno,dob);
    }
  }

  void createAccount(String email,String password,String username ,String age,String gender,String phoneno,String dob)async {
    try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        print("user crreated");
        if (userCredential.user != null) {

          String uid=userCredential.user!.uid;
          UserModel newuser=UserModel(
            uid: uid,
            email: email,
            password: password,
            username: username,
            pic: null,
            age: age,
            phoneno: phoneno,
            dob: dob,
            gender: gender
          );
        
          await FirebaseFirestore.instance.collection("users").doc(uid).set(newuser.toMap()).then((onValue){print("new user created!!");});
          Navigator.popUntil(context,(route)=>route.isFirst);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Homepage(userModel: newuser, firebaseuser:userCredential.user! )));
        }
      } on FirebaseAuthException catch (ex) {
        if (ex.code == "weak-password") {
          //show dialog
        }
        print(ex.code.toString());
      }
  }

 final FontWeight fb = FontWeight.bold;

 final FontWeight fw4 = FontWeight.w400;

  Text getText(
      {required String s, required double size, FontWeight? fw, Color? color}) {
    return Text(
      s,
      style: TextStyle(
          color: color ?? const Color.fromARGB(255, 72, 72, 72),
          fontWeight: fw ?? fw4,
          fontSize: size),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   title: Text("Smile Care Connect",style: TextStyle(
      //     fontSize: 30,
      //     fontWeight: FontWeight.bold,
      //     color: Colors.white
      //     ),),
      // ),
      body: SafeArea(
          child: Container(
        width: double.infinity,
        color: Colors.lightBlue,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: size.height * 0.06,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  getText(
                      s: "Welcome",
                      size: size.height * 0.08,
                      fw: fb,
                      color: Colors.white),
                  getText(
                      s: "This is your first step with us",
                      size: size.height * 0.021,
                      color: Colors.white),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Expanded(
                child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
              ),
              child: Padding(
                padding: EdgeInsets.all(size.height * 0.02),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: size.height * 0.022,
                      ),
                      getText(s: "Username", size: size.height * 0.02),
                      TextFormField(
                        controller: usernameC,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person_2),
                            hintText: "Enter Your Username",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2)),
                                borderSide:
                                    BorderSide(width: 1, color: Colors.white))),
                      ),
                      SizedBox(
                        height: size.height * 0.022,
                      ),
                      getText(s: "Email", size: size.height * 0.02),
                      TextFormField(
                        controller: emailC,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person_2),
                            hintText: "Enter Your email",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2)),
                                borderSide:
                                    BorderSide(width: 1, color: Colors.white))),
                      ),
                      SizedBox(
                        height: size.height * 0.022,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:<Widget> [
                        Expanded(child: customTextfield.getTextField("Age",size.height*0.02,ageC)),
                      Expanded(
                        child: DropdownButton<String>(
                            autofocus: true,
                            
                           hint: Text("please select",style: TextStyle(fontSize: size.height*0.02),),
                            focusColor: Colors.blue,
                            
                            value: gender,
                            items: item.map((String value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                gender = value;
                              });
                            }),
                      )
                      
                        ],
                      ),
                       SizedBox(
                        height: size.height * 0.022,
                      ),
                      getText(s: "Phone number", size: size.height * 0.02),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: PhoneC,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.phone),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2)),
                                borderSide:
                                    BorderSide(width: 1, color: Colors.white))),
                      ),
                      SizedBox(
                        height: size.height * 0.022,
                      ),
                      getText(s: "Date of birth", size: size.height * 0.02),
                      TextFormField(
                        controller: dobC,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.calendar_month),
                           hintText: "dd-mm-yyyy",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2)),
                                borderSide:
                                    BorderSide(width: 1, color: Colors.white))),
                      ),
                      SizedBox(
                        height: size.height * 0.022,
                      ),
                      getText(s: "Password", size: size.height * 0.02),
                      TextFormField(
                        controller: passwordC,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            hintText: "Enter your password",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2)),
                                borderSide:
                                    BorderSide(width: 1, color: Colors.white))),
                      ),
                      SizedBox(
                        height: size.height * 0.022,
                      ),
                      getText(s: "Confirm Password", size: size.height * 0.02),
                      TextFormField(
                        controller: cpasswordC,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            hintText: "Enter your password",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2)),
                                borderSide:
                                    BorderSide(width: 1, color: Colors.white))),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Center(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: const LinearBorder(),
                                backgroundColor: Colors.blue,
                                minimumSize:
                                    Size(size.width * 0.8, size.height * 0.06)),
                            onPressed: () {
                              checkvalues();
                              
                            },
                            child: Text(
                              "Sign up",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.height * 0.03),
                            )),
                      ),
                      SizedBox(
                        height: size.height * 0.015,
                      ),
                      Center(child: getText(s: "or", size: size.width * 0.05)),
                      Padding(
                        padding: EdgeInsets.all(size.height * 0.015),
                        child: InkWell(
                          onTap: () {},
                          child: Center(
                            child: Container(
                              width: size.width * 0.7,
                              height: size.height * 0.04,
                              decoration: BoxDecoration(
                                  border: Border.all(width: 1),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(25))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  //Image.asset("assets/images/glogo.png"),
                                  Image.asset(
                                    "assets/images/glogo.png",
                                    height: size.height * 0.065,
                                    width: size.width * 0.065,
                                  ),
                                  getText(
                                      s: "sign in with google",
                                      size: size.height * 0.02)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(CupertinoPageRoute(
                                builder: (context) => const LoginPage()));
                          },
                          child: getText(
                              s: "Already have an account? Click Here",
                              size: size.width * 0.03,
                              color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ))
          ],
        ),
      )),
    );
  }
}
