import 'package:dashboard/utils/showModalBottomSheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Floatingactionbuttonwidget extends StatelessWidget {
  Floatingactionbuttonwidget({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).cardColor,
      onPressed: () {
        Showmodalbottomsheet().show_ModalBottomSheet(context: context,
            titleController: titleController, descriptController: descriptController,
          flag: true
        );
      },
      child: Icon(Icons.add),
    );
  }
}
