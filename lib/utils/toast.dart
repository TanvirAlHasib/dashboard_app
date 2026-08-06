import 'package:flutter/material.dart';

class Toast {
  //constructor
  Toast(BuildContext this.context);
  BuildContext context;
  // function to show snackBar
  void show(String message){
    final SnackBar snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}