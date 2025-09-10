import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smile_care_connect/helpful/Uihelper.dart';
import 'package:smile_care_connect/models/userModel.dart';
import 'package:smile_care_connect/pages/completeprofile.dart';
import 'package:smile_care_connect/pages/login.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {



Widget inputFile({label,obscureText=false,controller})
{
return Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text(
      label,
      style: const TextStyle(
        fontSize:15 ,
        fontWeight: FontWeight.w400,
        color: Colors.black87,
      ),
    ),
    const SizedBox(height: 5,),
    TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 0,horizontal: 10),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade400
          )
        ),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade400
          ),
      ),
    ),
    ),
    const SizedBox(height: 10,)
  ],
);
}//input file


TextEditingController emailC=TextEditingController();
TextEditingController passwordC=TextEditingController();
TextEditingController cpasswordC=TextEditingController();


void checkvalues()
  {
   
    String email = emailC.text.trim();
    String password = passwordC.text.trim();
    String cpassword = cpasswordC.text.trim();
    if (email == "" || password == "" || cpassword == "") {
      //print("please fill all the details..");
      Uihelper.showAlertDialog(context,"Incomplete Data" ,"please fill all the details");
    } else if (cpassword != password) {
      //print("password do not match");
      Uihelper.showAlertDialog(context, "PassWord Mismatch", "password do not match");
    } else {
      //crrete useraccount using email and password
      createAccount(email,password);
    }
  }


void createAccount(String email,String password)async {
    try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        //print("user crreated");
        Uihelper.ShowLoadingdialog(context,"Creating New Account");
        if (userCredential.user != null) {

          String uid=userCredential.user!.uid;
          UserModel newuser=UserModel(
            uid: uid,
            email: email,
            password: password,
          );
        
          await FirebaseFirestore.instance.collection("users").doc(uid).set(newuser.toMap()).then((onValue){//print("new user created!!");
          });
          Navigator.popUntil(context,(route)=>route.isFirst);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Completeprofile(userModel: newuser, firebaseuser:userCredential.user! )));
        }
      } on FirebaseAuthException catch (ex) {
        if (ex.code == "weak-password") {
          //show dialog
          Uihelper.showAlertDialog(context, "Weak Password", "try using differnt password");
        }
        //print(ex.code.toString());
        Uihelper.showAlertDialog(context, "An error occurred", ex.code.toString());
      }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      
        leading:IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back_ios)) ,

      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
         // height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:<Widget> 
            [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:<Widget> [
                  const Text("Sign Up",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                      const SizedBox(height: 20,),
                  Text("This is your first step with us",style: TextStyle(fontSize: 15,
                  color: Colors.grey.shade700
                  ),),
                ],
              ),
              Column(
                children:<Widget> 
                [
                  inputFile(label: "Email",controller: emailC),
                  inputFile(label: "Password",obscureText: true,controller: passwordC),
                  inputFile(label: "Confirm Password",obscureText: true,controller: cpasswordC)
                ],
              ),
              Container(
                //padding: EdgeInsets.only(top: 3,left: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: const Border(
                     top: BorderSide(color: Colors.black),
                      bottom: BorderSide(color: Colors.black),
                      right:  BorderSide(color: Colors.black),
                      left:  BorderSide(color: Colors.black),
                  )
                ),
                child: MaterialButton(
                minWidth: double.infinity,
                height: 60,
                color: Colors.lightBlue,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Text("Sign up",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white
                ),),
                onPressed: (){
                  checkvalues();
                },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>
                [
                  const Text("Already have an account? "),
                  TextButton(
                    child: const Text("Log In",style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600
                  )),
                  onPressed: (){
                  //Navigator.pop(context);
                  Navigator.push(context, CupertinoPageRoute(builder: (context){
                    return const LoginPage();
                  }));},
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}