import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Textformfieldwidget extends StatelessWidget {
  const Textformfieldwidget({super.key, required String this.hintText, required IconData this.icon});
  final String hintText;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).inputDecorationTheme.fillColor,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
              color: Colors.grey.shade600,
              strokeAlign: BorderSide.strokeAlignOutside
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
              color: Colors.grey.shade400,
              strokeAlign: BorderSide.strokeAlignOutside
          ),
        ),
        prefixIcon: Icon(icon),
        hint: Text(hintText),
      ),
      style: TextStyle(
          fontSize: 16
      ),
    );
  }
}
