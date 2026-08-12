import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpensesScreen extends StatelessWidget {
  const ExpensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: MyAppBar(context),
    );
  }

  // app bar
  AppBar MyAppBar(BuildContext context){
    return AppBar(
      elevation: 3,
      title: Text("Expenses", style: TextStyle(fontSize: 19),),
      centerTitle: true,
      backgroundColor: Theme.of(context).cardColor,
    );
  }
}
