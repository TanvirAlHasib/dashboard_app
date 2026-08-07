import 'package:dashboard/models/task_model.dart';
import 'package:dashboard/utils/provider_state_management.dart';
import 'package:dashboard/utils/task_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../models/note_model.dart';
import '../widgets/textFormFieldWidget.dart';

class Showmodalbottomsheet {

  final _formKey = GlobalKey<FormState>();
  static int id = 0;
  static String category = "N/A";

  void show_ModalBottomSheet({required context, required TextEditingController titleController,
    required TextEditingController descriptController,
    required bool flag,
    required String flagFrom,
  }){
    showModalBottomSheet(context: context, isScrollControlled: true, builder: (context) {
      return Form(
        key: _formKey,
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.5 + MediaQuery.of(context).viewInsets.bottom * 0.8,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Text(
                getBottomSheetTitle(flagFrom, flag),
                style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight(600),
              ),),
              const SizedBox(
                height: 20,
              ),
              Textformfieldwidget(icon: Icons.title,
                textEditingController: titleController,
              ),
              const SizedBox(
                height: 13,
              ),
              ///TODO later i will fix the prefix icon issue in multiline textFormField by row widget
              Textformfieldwidget(icon: Icons.subtitles, maxLines: 4,
                textInputType: TextInputType.multiline,
                textEditingController: descriptController,
              ),
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
                        onPressed: () async{
                          if(_formKey.currentState!.validate()){

                            await makeTheAction(flagFrom, flag, context, titleController, descriptController);

                            titleController.clear();
                            descriptController.clear();
                            context.pop();
                          }
                        },
                        style: OutlinedButton.styleFrom(
                            textStyle: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight(600)
                            )
                        ),
                        child: Text(
                            flag ? "Add" : "Update"
                        )
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      );
    },);
  }

  // get the title of action
  String getBottomSheetTitle(String flagFrom, bool flag){
    if(flagFrom.contains("note")){
      return flag ? "Add Note" : "Update Note";
    } else {
      return flag ? "Add Task" : "Update Task";
    }
  }

  Future<void> makeTheAction(String flagFrom,
      bool flag, BuildContext context, TextEditingController titleController,
      TextEditingController descriptController) async{
      if(flagFrom.contains("note")){
        flag ? await context.read<ProviderStateManagement>().insertNote(NoteModel(
          title: titleController.text,
          description: descriptController.text,
          dateTime: DateTime.now().toLocal().toString(),
        )) : await context.read<ProviderStateManagement>().updateNote(NoteModel(
            title: titleController.text,
            description: descriptController.text,
            dateTime: DateTime.now().toLocal().toString(),
            id: id,
            category: category
      ));
    } else {
        await context.read<TaskProvider>().insertTask(TaskModel(
          title: titleController.text,
          subTitle: descriptController.text,
          dateTime: DateTime.now().toLocal().toIso8601String(),
          completed: 0,
          completedTask: 4,
        ));
      }
  }
}