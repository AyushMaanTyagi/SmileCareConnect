import 'package:flutter/material.dart';

class customTextfield{
  
  static TextField getReadTextField(String title,double size, String details)
  {
    TextEditingController controller=TextEditingController(text: details);
    return TextField(
      readOnly: true,
      controller: controller,
      cursorHeight: size,
      decoration: InputDecoration(
        label: Text(title,style: const TextStyle(color: Colors.lightBlue,fontWeight: FontWeight.bold),),
         filled: false,
         hintText: details,
        //  border: OutlineInputBorder(
        //   borderRadius: BorderRadius.all(Radius.circular(2)),
        //   borderSide: BorderSide(width: 1,color: Colors.white)
        //  )
    ),);
  }

  static TextField getTextField(String inputName,double size,TextEditingController controller) {
  return TextField(
    cursorHeight: size,
    controller: controller,
    decoration: InputDecoration(
        label: Text(inputName,),
        
        filled: true,
        //focusedBorder:OutlineInputBorder(borderSide: BorderSide(color: blue)) ,
        //focusColor: Colors.grey.shade200,
        //fillColor: Colors.grey.shade200,
        fillColor: Colors.white,
        border: const OutlineInputBorder()),
  );
}


static TextField getTextNumberField(String inputName,double size,TextInputType type ,TextEditingController controller) {
  return TextField(keyboardType: type,
    cursorHeight: size,
    controller: controller,
    decoration: InputDecoration(
        label: Text(inputName),
        filled: true,
        //  focusColor: Colors.grey.shade200,
        // fillColor: Colors.grey.shade200,
        //focusedBorder:OutlineInputBorder(borderSide: BorderSide(color: )) ,
        fillColor: Colors.white,
        border: const OutlineInputBorder()),
  );
}
}