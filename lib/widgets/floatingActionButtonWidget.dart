import 'package:dashboard/widgets/textFormFieldWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Floatingactionbuttonwidget extends StatelessWidget {
  const Floatingactionbuttonwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).cardColor,
      onPressed: () {
        showModalBottomSheet(context: context, builder: (context) {
          return Container(
            width: double.infinity,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Text("Add Note", style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight(600),
                ),),
                const SizedBox(
                  height: 20,
                ),
                Textformfieldwidget(icon: Icons.title),
                const SizedBox(
                  height: 13,
                ),
                ///TODO later i will fix the prefix icon issue in multiline textFormField by row widget
                Textformfieldwidget(icon: Icons.subtitles, maxLines: 4, textInputType: TextInputType.multiline,)
              ],
            ),
          );
        },);
      },
      child: Icon(Icons.add),
    );
  }
}
