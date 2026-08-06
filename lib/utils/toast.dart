import 'package:flutter/material.dart';

class Toast {
  //constructor
  Toast(BuildContext this.context);
  BuildContext context;
  // function to show snackBar
  void show(String message, VoidCallback function){
    final SnackBar snackBar = SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: "Yes",
        onPressed: function
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}