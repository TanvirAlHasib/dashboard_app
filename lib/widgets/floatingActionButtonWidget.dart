import 'package:dashboard/widgets/textFormFieldWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Floatingactionbuttonwidget extends StatelessWidget {
  const Floatingactionbuttonwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).cardColor,
      onPressed: () {
        showModalBottomSheet(context: context, isScrollControlled: true, builder: (context) {
          return Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.5 + MediaQuery.of(context).viewInsets.bottom * 0.8,
            padding: const EdgeInsets.all(15),
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
                Textformfieldwidget(icon: Icons.subtitles, maxLines: 4, textInputType: TextInputType.multiline,),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  spacing: 5,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                          onPressed: () {
                            context.pop();
                          },
                          style: OutlinedButton.styleFrom(
                            textStyle: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight(600)
                            )
                          ),
                          child: Text("Cancel")
                      ),
                    ),
                    Expanded(
                      child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                              textStyle: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight(600)
                              )
                          ),
                          child: Text("Add")
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        },);
      },
      child: Icon(Icons.add),
    );
  }
}
