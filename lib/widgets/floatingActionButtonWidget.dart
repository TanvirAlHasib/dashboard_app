import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Floatingactionbuttonwidget extends StatelessWidget {
  const Floatingactionbuttonwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      onPressed: () {},
      child: Icon(Icons.add),
    );
  }
}
