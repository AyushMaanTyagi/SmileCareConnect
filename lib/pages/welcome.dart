
import 'package:flutter/material.dart';
import 'package:smile_care_connect/pages/login.dart';
import 'package:smile_care_connect/pages/signup.dart';

class Welcomepage extends StatelessWidget
{
  const Welcomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: 
      Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>
          [
            const Column(
              children: <Widget>
              [
                Text("Welcome",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,

                ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
             Container(
                  height: MediaQuery.of(context).size.height/3,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                    image:   AssetImage("assets/images/welcome.png"),
                    )
                  ),
                ),

          Column(
            children: <Widget>
            [
              MaterialButton(
                minWidth: double.infinity,
                height: 60,
                onPressed: ()
                {
                  //Navigator.popUntil(context, (Route)=>Route.isFirst);
                  Navigator.push(context, MaterialPageRoute(builder: (context)
                  {
                    return const LoginPage();
                  }));
                },
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: Colors.black
                  ),
                  borderRadius: BorderRadius.circular(50)
                ),
                child: const Text("Login",
                style:TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ) ,
                ),
                ),
                const SizedBox(height: 20,),
            //signup button
          MaterialButton(
            minWidth: double.infinity,
            height: 60,
            onPressed:(){
             // Navigator.popUntil(context, (Route)=>Route.isFirst);
              Navigator.push(context, MaterialPageRoute(builder: (context)
              {
                return const SignupPage();
              }
              ));
              
            },
            color: Colors.lightBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Text("Sign Up",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
            ),
            )
            
            ],
          )

          ],
        ),
      )
      ),
    );
  }

}