import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smile_care_connect/helpful/Uihelper.dart';

import 'package:smile_care_connect/models/userModel.dart';
import 'package:smile_care_connect/pages/homepage.dart';

class Completeprofile extends StatefulWidget {
  final UserModel userModel;
  final User firebaseuser;
   const Completeprofile({super.key, required this.userModel,required this.firebaseuser});

  @override
  State<Completeprofile> createState() => _CompleteprofileState();
}

class _CompleteprofileState extends State<Completeprofile> {
  String? dropdownvalue="";
  String username="";
  String email="";
  String age="";
  String dob="";
  String phoneno="";
  List<String> items = ["Male", "Female", "Other"];
  final TextEditingController usernameC = TextEditingController();
  final TextEditingController emailC = TextEditingController();
  final TextEditingController ageC = TextEditingController();
  final TextEditingController dobC = TextEditingController();
  final TextEditingController PhoneC = TextEditingController();

  Widget inputFile(
      {label, obscureText = false, controller, TextInputType? type}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: type,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400)),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }

  Widget DisplayGender() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          "Gender",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        DropdownButton<String>(
            value: dropdownvalue,
            hint: const Text("please select"),
            icon: const Icon(Icons.arrow_drop_down_outlined),
            items: items.map((String? value) {
              return DropdownMenuItem(
                value: value,
                child: Text("$value"),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                dropdownvalue = value!;
              });
            }),
      ],
    );
  }

void checkvalues()
  {
     username=usernameC.text.trim();
     email = emailC.text.trim();
     age = ageC.text.trim();
     dob = dobC.text.trim();
     phoneno = PhoneC.text.trim();

    if (email == ""||username==""||age==""||phoneno==""||dob==""||dropdownvalue=="") {
      //print("please fill all the details..");
      Uihelper.showAlertDialog(context, "Incomplete data", "please fill all the details");
    } else {
      //log("uploading data");
      Uihelper.ShowLoadingdialog(context,"Setting Up Account");
      uploadData();
    }
  }

void uploadData()async
{
  widget.userModel.username=username;
  widget.userModel.email=email;
  widget.userModel.age=age;
  widget.userModel.dob=dob;
  widget.userModel.gender=dropdownvalue;
  widget.userModel.phoneno=phoneno;
 await FirebaseFirestore.instance.collection("users").doc(widget.userModel.uid!).set(widget.userModel.toMap()).then((value)
 {
  log("data uploaded !!");
  Navigator.push(context, MaterialPageRoute(builder: (context)
  {
    return Homepage(userModel:widget.userModel, firebaseuser: widget.firebaseuser);
  }));
 });

}

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        
        backgroundColor: Colors.white,
      ),
      body: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
           // height: MediaQuery.of(context).size.height,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Let's set up an account for you",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Please fill the required details",
                      style: TextStyle(fontSize: 15),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CircleAvatar(
                      radius: size.height * 0.08,
                      backgroundColor: Colors.lightBlue,
                      child: Icon(
                        Icons.person,
                        size: size.height * 0.08,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding:  EdgeInsets.all(size.height*0.02),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      inputFile(
                          label: "Username",
                          type: TextInputType.name,
                          controller: usernameC),
                      inputFile(label: "Email", type: TextInputType.emailAddress,controller: emailC),
                     
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(child: DisplayGender()),
                          //SizedBox(width: size.width*0.2,),
                          Expanded(
                            child: inputFile(
                                label: "Age",
                                type: TextInputType.number,
                                controller: ageC),
                          )
                        ],
                      ),
                      inputFile(
                          label: "Phone number",
                          type: TextInputType.phone,
                          controller: PhoneC),
                      inputFile(
                          label: "Date of birth",
                          type: TextInputType.datetime,
                          controller: dobC),
                
                    ],
                  ),
                ),
               MaterialButton(minWidth: double.infinity,
               
                height: 60,
              color: Colors.lightBlue,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50)
              ),
                onPressed: () =>checkvalues() ,child: const Text("Done",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white
                
                ),
                ),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
