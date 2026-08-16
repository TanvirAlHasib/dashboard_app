import 'package:dashboard/utils/showModalBottomSheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Floatingactionbuttonwidget extends StatelessWidget {
  Floatingactionbuttonwidget({super.key, required this.flagFrom, this.categoryList});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptController = TextEditingController();
  final String flagFrom;
  final List<String> ? categoryList;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).cardColor,
      onPressed: () {
        Showmodalbottomsheet().show_ModalBottomSheet(context: context,
            titleController: titleController, descriptController: descriptController,
          flag: true, flagFrom: flagFrom,
          categoryList: categoryList
        );
      },
      child: Icon(Icons.add),
    );
  }
}
