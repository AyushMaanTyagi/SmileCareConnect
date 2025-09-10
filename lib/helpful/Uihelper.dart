import 'package:flutter/material.dart';
import 'package:smile_care_connect/pages/welcome.dart';

class Uihelper{
  static void ShowLoadingdialog(BuildContext context, String title)
  {
    AlertDialog loadingdialog =AlertDialog(
      content: Container(
        child: Column(
          mainAxisSize:  MainAxisSize.min,
          children: [
            Text(title,style:const TextStyle(fontSize: 20) ,),
            const SizedBox(height: 30,),
             const CircularProgressIndicator()
          ],
        ),
      ),
    );
    showDialog(context: context, barrierDismissible:false,builder: (context)
    {
      return loadingdialog;
    });
  }


static void showAlertDialog(BuildContext context,String title,String content)
{
  AlertDialog alertDialog= AlertDialog(
    title: Text(title),
    content: Text(content,style: const TextStyle(fontSize: 15),),
    actions: [
      TextButton(onPressed: (){Navigator.pop(context);}, child: const Text("Ok"))
    ],
  );
  showDialog(context: context, builder: (context)
  {
    return alertDialog;
  });
}

static void logout(BuildContext context,String title,String content)
{
  AlertDialog logoutDialog=AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: [
      TextButton(onPressed: (){
        Navigator.pop(context);
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)
        {
          return const Welcomepage();
        }));
      }, child: const Text("Yes")),
      TextButton(onPressed: (){
        Navigator.pop(context);
      }, child: const Text("No"))
    ],
  );

  showDialog(context: context, builder: (context)
  {
    return logoutDialog;
  });
}
}