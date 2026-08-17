import 'package:dashboard/models/expense_model.dart';
import 'package:dashboard/models/task_model.dart';
import 'package:dashboard/utils/expense_provider.dart';
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
  static String ? selectedCategory;

  void show_ModalBottomSheet({required context, required TextEditingController titleController,
    required TextEditingController descriptController,
    required bool flag,
    required String flagFrom,
    List<String> ? categoryList,
  }){
    if (categoryList != null && (selectedCategory == null || !categoryList.contains(selectedCategory))) {
      selectedCategory = categoryList.first;
    }
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
          child: StatefulBuilder(
            builder: (context, setState) {
              return Column(
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
                  DropdownButton<String>(
                    value: selectedCategory,
                    elevation: 3,
                    isExpanded: true,
                    dropdownColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    underline: Container(
                      height: 1,
                      color: Colors.blue.shade400,
                    ),
                    items: categoryList!.map((item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    },).toList(),
                    onChanged: (value) {
                      setState(() => selectedCategory = value!);
                    },
                  ),
                  const SizedBox(
                    height: 15,
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
              );
            },
          ),
        ),
      );
    },);
  }

  // get the title of action
  String getBottomSheetTitle(String flagFrom, bool flag){
    if(flagFrom.contains("note")){
      return flag ? "Add Note" : "Update Note";
    } else if(flagFrom.contains("task")){
      return flag ? "Add Task" : "Update Task";
    } else {
      return flag ? "Add Expense" : "Update Expense";
    }
  }

  Future<void> makeTheAction(String flagFrom,
      bool flag, BuildContext context, TextEditingController titleController,
      TextEditingController descriptController) async{
      if(flagFrom.contains("note")){
        flag ? await context.read<ProviderStateManagement>().insertNote(NoteModel(
          title: titleController.text,
          description: descriptController.text,
          dateTime: DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          ).toString().split(" ").first,
          category: selectedCategory!
        )) : await context.read<ProviderStateManagement>().updateNote(NoteModel(
            title: titleController.text,
            description: descriptController.text,
            dateTime: DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
            ).toString().split(" ").first,
            id: id,
            category: selectedCategory!
      ));
    } else if(flagFrom.contains("task")) {
        flag ? await context.read<TaskProvider>().insertTask(TaskModel(
          title: titleController.text,
          subTitle: descriptController.text,
          dateTime: DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          ).toString().split(" ").first,
          completed: 0,
          category: selectedCategory!
        )) : await context.read<TaskProvider>().updateTask(TaskModel(
          title: titleController.text,
          subTitle: descriptController.text,
          dateTime: DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          ).toString().split(" ").first,
          category: selectedCategory!,
          taskId: id
        ));
      } else {
        flag ? await context.read<ExpenseProvider>().insertExpense(ExpenseModel(
            title: titleController.text,
            expense: int.parse(descriptController.text),
            category: selectedCategory!
        )) : await context.read<ExpenseProvider>().updateExpense(ExpenseModel(
            title: titleController.text,
            expense: int.parse(descriptController.text),
            category: selectedCategory!,
            id: id
        ));
      }
  }
}