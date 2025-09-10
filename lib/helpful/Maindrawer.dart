// ignore_for_file: prefer_const_constructors


import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:smile_care_connect/helpful/Uihelper.dart';

import 'package:smile_care_connect/models/userModel.dart';
import 'package:smile_care_connect/pages/About.dart';
import 'package:smile_care_connect/pages/doctorlist.dart';
import 'package:smile_care_connect/pages/homepage.dart';
import 'package:smile_care_connect/pages/login.dart';

import 'package:smile_care_connect/pages/profile.dart';
import 'package:smile_care_connect/pages/videosection.dart';
class MainDrawer extends StatefulWidget {

  final UserModel userModel;
  final User firebaseuser;
  const  MainDrawer({super.key,required this.firebaseuser,required this.userModel});

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
void changeSelected(int index,dynamic ClassID)
{
 setState(() { _selected=index;
  });
  //Navigator.of(context).popUntil((predicate) => predicate.isFirst);
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => ClassID),
    );
}

logout(String title,String content) 
{
  AlertDialog alertDialog=AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: [
      TextButton(onPressed: ()async=> {
        await FirebaseAuth.instance.signOut(),
        Navigator.popUntil(context,(Route)=>Route.isFirst),
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)
        {
          return LoginPage();
        }))
      }, child: Text("Yes")),
      TextButton(onPressed: ()=>Navigator.pop(context), child: Text("No"))
    ],
  );

showDialog(context: context, builder: (context)
{
  return alertDialog;
},
barrierDismissible: false,
);

}



int _selected=1;
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Drawer(
      child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                color: Colors.blue,
                //
                child:Center(
                  child: Column(
                    children:<Widget> [
                      Container(
                width: 100,
                height: 100 ,
                margin: EdgeInsets.only(top: 30,bottom: 10),
                //   decoration: BoxDecoration(
                //   shape: BoxShape.circle,
                //   image: DecorationImage(image: AssetImage("assets/images/teeth.jpg"),
                //   fit: BoxFit.cover
                //   ),
                // ),
                child: CircleAvatar(
                  radius:30 ,
                  backgroundImage: (widget.userModel.pic==null)?null:NetworkImage(widget.userModel.pic!
                  ),
                  
                  child: (widget.userModel.pic==null)?Icon(Icons.person):null,
                ),
                      ),
                      Text(widget.userModel.username!,style: TextStyle(fontSize: size.height*0.03,color: Colors.white),),
                      Text(widget.userModel.email!,style: TextStyle(fontSize: size.height*0.02,color: Colors.white),)
                    ],
          
                  ),
                ),
              ),
               ListTile(
                selected:_selected==0,
                leading: Icon(Icons.person,size: 28,),
                title: Text("Profile",style: TextStyle(fontSize: 20),),
                onTap: (){
                changeSelected(0,Profile(userModel: widget.userModel, firebaseuser: widget.firebaseuser,));
              }),
               ListTile(
                selected:_selected==1,
                leading: Icon(Icons.home,size: 28,),
                title: Text("Home",style: TextStyle(fontSize: 20),),
                onTap: (){
                
              changeSelected(1,Homepage(userModel: widget.userModel, firebaseuser: widget.firebaseuser,));
                }
               ),
               ListTile(
                selected:_selected==2,
                leading: Icon(Icons.video_collection,size: 28,),
                title: Text("Video Section",style: TextStyle(fontSize: 20),),
               onTap: (){
                changeSelected(2,VideoSec(userModel: widget.userModel, firebaseuser: widget.firebaseuser,));
                }
               ),
               ListTile(
                selected:_selected==3,
                leading: Icon(Icons.person,size: 28,),
                title: Text("View Dentists",style: TextStyle(fontSize: 20),),
                onTap: (){
              changeSelected(3,Doctorlist(userModel: widget.userModel, firebaseuser: widget.firebaseuser,));
                }
               ),
                Divider(
                thickness: 2,
                indent: 10,
                endIndent: 10,
               ),
               ListTile(
                selected:_selected==4,
                leading: Icon(Icons.settings,size: 28,),
                title: Text("Settings",style: TextStyle(fontSize: 20),),
                //onTap: ()=>changeSelected(4),
               ),
               ListTile(
                selected:_selected==5,
                leading: Icon(Icons.adobe,size: 28,),
                title: Text("About",style: TextStyle(fontSize: 20),),
                onTap: ()=>changeSelected(5,About(userModel: widget.userModel, firebaseuser: widget.firebaseuser,)),
               ),
               Divider(
                thickness: 2,
                indent: 10,
                endIndent: 10,
               ),
               ListTile(
                selected:_selected==6,
                leading: Icon(Icons.logout,size: 28,),
                title: Text("Logout",style: TextStyle(fontSize: 20),),
                onTap: ()=>{Uihelper.logout(context,"Are you sure to log out","We will miss you"),}
                ),
            ],
          ),
    );
  }
}