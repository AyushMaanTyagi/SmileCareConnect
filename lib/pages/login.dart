import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smile_care_connect/helpful/Uihelper.dart';
import 'package:smile_care_connect/models/userModel.dart';
import 'package:smile_care_connect/pages/homepage.dart';
import 'package:smile_care_connect/pages/signup.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailC=TextEditingController();
  TextEditingController passC=TextEditingController();


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
}

void checkvalues()
{
  String email=emailC.text.trim();
  String password=passC.text.trim();

  if(email==""||password=="")
  {
    Uihelper.showAlertDialog(context, "Incomplete Data", "please fill all the details");
  }
  else
  {
    login(email,password);
  }
}

void login(String email,String password) async
{
   UserCredential? userCredential;
   Uihelper.ShowLoadingdialog(context, "Logging In..");
   try {
     userCredential=await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
   } on FirebaseAuthException catch (e) {
     //print(e.code.toString()+"hello");
     Uihelper.showAlertDialog(context, "An error Occurred", e.code.toString());
   }
    if(userCredential!=null)
      {
        String uid=userCredential.user!.uid;
        
        DocumentSnapshot userData=await FirebaseFirestore.instance.collection("users").doc(uid).get();
        UserModel usermodel=UserModel.fromMap(userData.data()as Map<String,dynamic>);

        if(password==usermodel.password && email==usermodel.email)
        {
          Uihelper.ShowLoadingdialog(context, "Login Successful");
          Navigator.popUntil(context,(Route)=>Route.isFirst);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Homepage(userModel: usermodel, firebaseuser:userCredential!.user!)));
        }
        
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
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back_ios,size: 20,color: Colors.black,)),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width:double.infinity ,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: <Widget>
          [
            Expanded(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:<Widget> [

                Column(
                  children:<Widget> [
                    const Text("Login",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                    const SizedBox(height: 20,),
                Text("Login to your account",style: TextStyle(fontSize: 15,
                color: Colors.grey.shade700
                ),)
                  ],
                ),
                Padding(padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: <Widget>
                  [
                    inputFile(label: "Email",controller: emailC),
                    inputFile(label: "Password",obscureText: true,controller: passC)
                  ],
                ),),
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 40),
                   child: Container(
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
                      borderRadius:  BorderRadius.circular(50),
                    ),
                     
                    child: const Text("Login",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white
                    ),),
                   
                   
                    onPressed:(){
                      checkvalues();

                    },
                    ),
                    ),
                 ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:<Widget> 
                [
                  const Text("Don't have an account?",),

                  TextButton(
                      child: const Text("Sign Up",style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600
                    )),
                    onPressed: (){//Navigator.pop(context);
                    Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context){
                      return const SignupPage();
                    }));},
                    )
                ],
              ),

            Container(
              padding: const EdgeInsets.only(top: 100),
              height: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/background.png"),
                fit: BoxFit.fitHeight)
              ),
            )

              ],
            ))
          ],
        ),
      )
    );
    
  }
}
