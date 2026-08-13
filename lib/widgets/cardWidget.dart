import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Cardwidget extends StatelessWidget {
  const Cardwidget({super.key, required String this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(18)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        child: Text(text, style:TextStyle(
          fontSize: 16,
          fontWeight: FontWeight(600)
        ),
        ),
      ),
    );
  }
}
