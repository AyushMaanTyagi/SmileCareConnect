import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smile_care_connect/helpful/Maindrawer.dart';
import 'package:smile_care_connect/helpful/Uihelper.dart';
import 'package:smile_care_connect/models/userModel.dart';
import 'package:smile_care_connect/helpful/customTextfield.dart';

class Profile extends StatefulWidget {
  final UserModel userModel;
  final User firebaseuser;
  const Profile({super.key, required this.userModel, required this.firebaseuser});


  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
final FontWeight fb = FontWeight.bold;

final FontWeight fw4 = FontWeight.w400;
 File? imageFile;

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

void select_image(ImageSource source)async{
XFile? pickedFile = await ImagePicker().pickImage(source: source);
if(pickedFile != null)
{
  crop_image(pickedFile);
}
}
void crop_image(XFile pickedFile)async{

  CroppedFile? croppedFile= await ImageCropper().cropImage(
    sourcePath: pickedFile.path,
    compressQuality: 10,
    //compressFormat: ImageCompressFormat.jpg
  );
  if(croppedFile != null)
  {
    setState(() {
      imageFile=File(croppedFile.path);
    });
     if(imageFile!= null)
  {
    log("uploading photo");
    Uihelper.ShowLoadingdialog(context,"Uploading profile picture");
     uploadPhoto();
  }

  }
}

void showPhotoOptions()
{
  showDialog(context: context, builder: (context)
  {
return AlertDialog(title: const Text("Upload Profile Photo"),
content: Column(
  mainAxisSize: MainAxisSize.min,
  children: [
    ListTile(
      leading:const Icon(Icons.photo_album) ,
      title: const Text("select from gallery"),
      onTap: (){
        Navigator.pop(context);
        select_image(ImageSource.gallery);
        },
    ),
    ListTile(
      leading: const Icon(Icons.camera_alt),
      title: const Text("Take a photo"),
       onTap: (){
        Navigator.pop(context);
        select_image(ImageSource.camera);
        },
      )

  ],
),
);
  });
 
}
void uploadPhoto()async
{
 UploadTask uploadTask = FirebaseStorage.instance.ref("profilepictures").child(widget.userModel.uid!).putFile(imageFile!);
 TaskSnapshot snapshot = await uploadTask;
 String imageUrl = await  snapshot.ref.getDownloadURL();

 widget.userModel.pic = imageUrl;

 await FirebaseFirestore.instance.collection("users").doc(widget.userModel.uid!).set(widget.userModel.toMap()).then((value)=>log("data uploaded"));
}



  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;  
    
    return 
    Scaffold(
       appBar: AppBar(
        centerTitle: true,
        title: const Text("Profile",
        style: TextStyle(fontSize: 25),
        ),
        backgroundColor: Colors.blue,
      ),
      drawer: MainDrawer(firebaseuser: widget.firebaseuser, userModel: widget.userModel),
      body: SafeArea(
      child:Container(
       padding: const EdgeInsets.symmetric(
        horizontal: 40
      ),
      child: ListView(
        children: <Widget>[
            SizedBox(height: size.height*0.08,),
           Stack(
            children: [
              (imageFile==null)?
             Center(
               child: CircleAvatar (
                radius: 70,
                backgroundImage: (widget.userModel.pic==null)?null:NetworkImage(widget.userModel.pic!),
                backgroundColor: Colors.grey.shade400,
                child: (widget.userModel.pic==null)? const Icon(Icons.person,size: 70,color: Colors.white,):null,
               // child: Icon(Icons.person,size: 60,),
               ),
             ):Center(
               child: CircleAvatar (
                radius: 70,
                backgroundImage: FileImage(imageFile!),
                backgroundColor: Colors.grey.shade400,
                //child:  const Icon(Icons.person,size: 70,color: Colors.white,),
               // child: Icon(Icons.person,size: 60,),
               ),
             ),
             
             Positioned(
               bottom: 5,
               right: size.width*0.2,
               child: Container(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle
                ),
                 child: IconButton(
                 icon: const Icon(Icons.add_a_photo,color: Colors.white,),
                 onPressed: (){
                  showPhotoOptions();
                 },
                 ),
               ),
             )
            ]
           ),
           SizedBox(height: size.height*0.022,),
         customTextfield.getReadTextField("Username",size.height*0.02 ,widget.userModel.username!),
        SizedBox(height: size.height*0.022,),
         customTextfield.getReadTextField("Age",size.height*0.02,widget.userModel.age!),
          const SizedBox(height: 30,),
          customTextfield.getReadTextField("Gender",size.height*0.02,widget.userModel.gender!),
         SizedBox(height: size.height*0.022,),
          customTextfield.getReadTextField("Email",size.height*0.02,widget.userModel.email!),
           SizedBox(height: size.height*0.022,),
           
        customTextfield.getReadTextField("Phone Number",size.height*0.02,widget.userModel.phoneno!),
          SizedBox(height: size.height*0.022,),
         customTextfield.getReadTextField("Dob",size.height*0.02,widget.userModel.dob!),
          ]
        ),
       )) 
    );
    
  }
}