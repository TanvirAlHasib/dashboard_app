import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Textformfieldwidget extends StatelessWidget {
  const Textformfieldwidget({super.key, this.hintText = "",
    required this.icon,
    this.maxLines = 1,
    this.textInputType = TextInputType.text,
    required this.textEditingController,
  });
  final String hintText;
  final IconData icon;
  final int maxLines;
  final TextInputType textInputType;
  final TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      maxLines: maxLines,
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
      validator: (value) {
        if(value == null || value.isEmpty){
          return "Title field can not be empty";
        }
      },
    );
  }
}
