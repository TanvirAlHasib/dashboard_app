import 'package:dashboard/utils/showModalBottomSheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Floatingactionbuttonwidget extends StatelessWidget {
  Floatingactionbuttonwidget({super.key, required this.flagFrom});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptController = TextEditingController();
  final String flagFrom;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).cardColor,
      onPressed: () {
        Showmodalbottomsheet().show_ModalBottomSheet(context: context,
            titleController: titleController, descriptController: descriptController,
          flag: true, flagFrom: flagFrom,
        );
      },
      child: Icon(Icons.add),
    );
  }
}
