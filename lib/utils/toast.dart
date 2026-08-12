import 'package:flutter/material.dart';

class Toast {
  //constructor
  Toast(this.context);
  BuildContext context;
  // function to show snackBar
  void show(String message, VoidCallback function){
    final SnackBar snackBar = SnackBar(
      content: Text(message, style: TextStyle(color: Colors.black),),
      action: SnackBarAction(
        label: "Yes",
        onPressed: function,
        textColor: Colors.black,
      ),
      backgroundColor: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(8)),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      closeIconColor: Colors.black,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}