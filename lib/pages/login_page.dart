// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:smile_care_connect/models/userModel.dart";
import "package:smile_care_connect/pages/homepage.dart";
import "package:smile_care_connect/pages/signup_page.dart";


class LoginPage extends StatefulWidget {
 const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
 TextEditingController emailC=TextEditingController();

 TextEditingController passwordc=TextEditingController();

void checkvalues()
{
  String email=emailC.text.trim();
  String password=passwordc.text.trim();

  if(email==""||password=="")
  {
    print("please fill all the dtails");
  }
  else
  {
    login(email,password);
  }
}

void login(String email,String password) async
{
   UserCredential? userCredential;
   try {
     userCredential=await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
   } on FirebaseAuthException catch (e) {
     print("${e.code}hello");
   }
    if(userCredential!=null)
      {
        String uid=userCredential.user!.uid;
        
        DocumentSnapshot userData=await FirebaseFirestore.instance.collection("users").doc(uid).get();
        UserModel usermodel=UserModel.fromMap(userData.data()as Map<String,dynamic>);

        if(password==usermodel.password && email==usermodel.email)
        {
          //Uihelper.ShowLoadingdialog(context, "Login Successful");
          Navigator.popUntil(context,(Route)=>Route.isFirst);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Homepage(userModel: usermodel, firebaseuser:userCredential!.user!)));
        }
        
      
     }

  
}

final FontWeight fb = FontWeight.bold;

final FontWeight f4 = FontWeight.w400;

Text getText({required String s, required double size, FontWeight? fw,Color? color}) {
  return Text(
    s,
    style: TextStyle(
        color:color?? const Color.fromARGB(255, 72, 72, 72), fontSize: size, fontWeight: fw ?? f4),
  );
}

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          // padding: EdgeInsets.symmetric(vertical: 30),
          width: double.infinity,
          color: Colors.blue,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: size.height * 0.06,
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    getText(
                        s: "Welcome Back!!",
                        size: size.height * 0.05,
                        fw: fb,
                        color: Colors.white),
                    getText(
                        s: "You've bee missed!!",
                        size: size.height * 0.02,
                        color: Colors.white),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
                child: Padding(
                  padding: EdgeInsets.all(size.height * 0.03),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: size.height * 0.025,
                        ),
                        getText(s: "Email", size: size.height * 0.02),
                        TextFormField(
                          controller: emailC,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                              hintText: ("Enter your email"),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.grey),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2)))),
                        ),
                        
                        SizedBox(
                          height: size.height * 0.025,
                        ),
                        getText(s: "Password", size: size.height * 0.02),
                        TextFormField(
                          controller: passwordc,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                              hintText: ("Enter your password"),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.grey),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2)))),
                        ),
                        SizedBox(
                          height: size.height * 0.025,
                        ),
                        SizedBox(
                          height: size.height * 0.025,
                        ),
                        Center(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: LinearBorder(),
                                  backgroundColor: Colors.blue,
                                  minimumSize: Size(
                                      size.width * 0.8, size.height * 0.06)),
                              onPressed: () {
                                checkvalues();
                              },
                              child: Text(
                                "Log In",
                                style: TextStyle(color: Colors.white,fontSize: size.height*0.03),
                              )),
                        ),
                        SizedBox(
                          height: size.height * 0.015,
                        ),
                        Center(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(CupertinoPageRoute(
                                  builder: (context) => SignupPage()));
                            },
                            child: getText(
                                s: "Don't have an account? Click Here",
                                size: size.width * 0.03,
                                color: Colors.blue),
                          ),
                        ),
                        
                        // 
                      ],
                    ),
                  ),
                ),

              ))
            ],
          ),
        ),
      ),
      
    );
  }
}