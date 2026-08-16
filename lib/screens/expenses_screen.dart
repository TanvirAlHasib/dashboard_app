import 'package:dashboard/models/budget_model.dart';
import 'package:dashboard/models/expense_model.dart';
import 'package:dashboard/utils/expense_provider.dart';
import 'package:dashboard/utils/showModalBottomSheet.dart';
import 'package:dashboard/utils/toast.dart';
import 'package:dashboard/widgets/cardWidget.dart';
import 'package:dashboard/widgets/floatingActionButtonWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../widgets/textFormFieldWidget.dart';

class ExpensesScreen extends StatelessWidget {
  ExpensesScreen({super.key});

  final TextEditingController budgetController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final List<String> categoryList = ["Food", "Travel", "Bills", "Shopping"];

  final Floatingactionbuttonwidget _floatingactionbuttonwidget = Floatingactionbuttonwidget(flagFrom: "expenses");
  final Showmodalbottomsheet  _showmodalbottomsheet = Showmodalbottomsheet();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: MyAppBar(context),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 22),
        child: Consumer<ExpenseProvider>(
          builder: (ctx, provider, _) {

            List<ExpenseModel> expenseList = provider.getExpensesList;
            List<BudgetModel> budgetList = provider.getBudgetList;

            if(expenseList.isEmpty && (ExpenseProvider.categoryFlag != true)){
              return SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: .center,
                  mainAxisAlignment: .center,
                  spacing: 8,
                  children: [
                    budgetList.isEmpty ? Column(
                      spacing: 8,
                      children: [
                        Text("Add Budget of the Month",textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16
                          ),),
                        FilledButton(
                            onPressed: (){
                              addBudget(context: context, flag: true);
                            },
                            style: FilledButton.styleFrom(
                              backgroundColor: Colors.blue.shade800,
                            ),
                            child: Text("Add Budget", style: TextStyle(
                                fontWeight: FontWeight(600)
                            ),))
                      ],
                    ) : Text("No Expenses yet.",textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16
                      ),)
                  ],
                ),
              );
            }

            return Column(
              crossAxisAlignment: .start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 17, bottom: 23),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Theme.of(context).cardColor,
                            Color(0XFFF8F9FF),
                            Colors.white
                          ],
                          begin: AlignmentGeometry.topEnd,
                          end: AlignmentGeometry.bottomStart
                      ),
                      borderRadius: BorderRadiusGeometry.circular(10),
                      border: BoxBorder.all(
                          color: Colors.blue.shade200,
                          width: 0.5
                      )
                  ),
                  child: Column(
                    spacing: 15,
                    children: [
                      Text("TOTAL SPENT THIS MONTH", style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade700
                      ),),
                      Text("${ExpenseProvider.totalSpent} tk", style: TextStyle(
                          fontSize: 32,
                          color: Color(0XFF0B1C30),
                          fontWeight: FontWeight(600)
                      ),),
                      Row(
                        mainAxisAlignment: .center,
                        spacing: 17,
                        children: [
                          Stack(
                            alignment: AlignmentGeometry.center,
                            children: [
                              Text("${((ExpenseProvider.totalSpent / ExpenseProvider.totalBudget) * 100 ).toInt()}%",
                                style: TextStyle(
                                fontWeight: FontWeight(700),
                                color: Colors.blue.shade700,
                              ),),
                              CircularProgressIndicator.adaptive(
                                strokeAlign: 3,
                                backgroundColor: Colors.blue.shade100,
                                strokeWidth: 5,
                                value: (ExpenseProvider.totalSpent / ExpenseProvider.totalBudget),
                                valueColor: AlwaysStoppedAnimation(Colors.blue.shade700),
                              )
                            ],
                          ),
                          Text("used of your ${ExpenseProvider.totalBudget} tk budget", style: TextStyle(
                              color: Colors.grey.shade700
                          ),)
                        ],
                      ),
                      // add budget button
                      const SizedBox(
                        height: 0,
                      ),
                      FilledButton(
                          onPressed: () {
                            addBudget(context: context, id: budgetList[0].id, flag: false);
                          },
                          style: FilledButton.styleFrom(
                              elevation: 0,
                              backgroundColor: Colors.white,
                              minimumSize: Size.fromHeight(40),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.circular(17),
                                  side: BorderSide(
                                      strokeAlign: BorderSide.strokeAlignOutside,
                                      color: Colors.blue.shade50,
                                      width: 0.6
                                  )
                              )
                          ),
                          child: Text("Update Budget", style: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight(600)
                          ),)
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 17,
                ),
                Text("Categories", style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight(600),
                ),),
                const SizedBox(
                  height: 12,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () async{
                            await provider.getExpenseByCategory("All");
                          },
                          child: Cardwidget(text: "All")
                      ),
                      InkWell(
                          onTap: () async{
                            await provider.getExpenseByCategory("Food");
                          },
                          child: Cardwidget(text: "Food")
                      ),
                      InkWell(
                          onTap: () async{
                            await provider.getExpenseByCategory("Travel");
                          },
                          child: Cardwidget(text: "Travel")
                      ),
                      InkWell(
                          onTap: () async{
                            await provider.getExpenseByCategory("Bills");
                          },
                          child: Cardwidget(text: "Bills")
                      ),
                      InkWell(
                          onTap: () async{
                            await provider.getExpenseByCategory("Shopping");
                          },
                          child: Cardwidget(text: "Shopping")
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 17,
                ),
                Text("Transactions", style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight(600),
                ),),
                const SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: ListViewBulder(expenseList, provider),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: Consumer<ExpenseProvider>(builder: (_, provider, _) {
        if(provider.getBudgetList.isEmpty){
          return const SizedBox.shrink();
        }

        return Floatingactionbuttonwidget(flagFrom: "expenses", categoryList: categoryList,);

      },),
    );
  }

  // app bar
  AppBar MyAppBar(BuildContext context){
    return AppBar(
      elevation: 3,
      title: Text("Expenses", style: TextStyle(fontSize: 19),),
      centerTitle: true,
      backgroundColor: Theme.of(context).cardColor,
    );
  }

  // add budget functionality
  void addBudget({required BuildContext context, int ? id, required  bool flag}){
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.5 + MediaQuery.of(context).viewInsets.bottom * 0.8,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  flag ? "Add Monthly Budget" : "Update Monthly Budget",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight(600),
                  ),),
                const SizedBox(
                  height: 20,
                ),
                Textformfieldwidget(
                    icon: Icons.money,
                    textEditingController: budgetController
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

                              String dateTime = DateTime(
                                  DateTime.now().year,
                                  DateTime.now().month,
                                  DateTime.now().day
                              ).toIso8601String();
                              // insert or update budget to the budget table
                              flag ? await context.read<ExpenseProvider>().insertBudget(BudgetModel(
                                  budget: int.parse(budgetController.text),
                                  DateTime: dateTime
                              )) : await context.read<ExpenseProvider>().updateBudget(BudgetModel(
                                  budget: int.parse(budgetController.text),
                                  DateTime: dateTime,
                                  id: id,
                              ));

                              budgetController.clear();
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
      },
    );
  }

  // list view builder for expense list
  Widget ListViewBulder(List<ExpenseModel> expenseList, ExpenseProvider provider){
    return ListView.builder(
      itemCount: expenseList.isNotEmpty ? expenseList.length : 1,
      itemBuilder: (context, index) {
        if(expenseList.isEmpty && ExpenseProvider.categoryFlag){
          return SizedBox(
            width: double.infinity,
            height: 200,
            child: Column(
              crossAxisAlignment: .center,
              mainAxisAlignment: .center,
              spacing: 8,
              children: [
                Text("No Expenses yet.",textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16
                  ),)
              ],
            ),
          );
        }
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.money, color: Colors.blue.shade500,),
                ),
                title: Row(
                  spacing: 5,
                  children: [
                    Text("-${expenseList[index].expense} tk"),
                    Expanded(
                      child: Center(
                        child: Card(
                          elevation: 0,
                          color: Colors.amber.shade50,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 4),
                            child: Text(expenseList[index].category, overflow: TextOverflow.ellipsis, style: TextStyle(
                                fontSize: 12
                            ),),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                subtitle: Text(expenseList[index].title),
                trailing: Row(
                  mainAxisSize: .min,
                  children: [
                    IconButton(
                        onPressed: () {
                          Toast(
                              context).show("Do you want to delete the expense ?",
                                () async => await provider.deleteExpense(expenseList[index].id!),
                          );
                        }, icon: Icon(Icons.delete, color: Colors.red.shade700, size: 23,)),
                    IconButton(onPressed: () {
                      _floatingactionbuttonwidget.titleController.text = expenseList[index].title;
                      _floatingactionbuttonwidget.descriptController.text = expenseList[index].expense.toString();
                      Showmodalbottomsheet.id = expenseList[index].id!;
                      _showmodalbottomsheet.show_ModalBottomSheet(
                        context: context,
                        titleController: _floatingactionbuttonwidget.titleController,
                        descriptController: _floatingactionbuttonwidget.descriptController,
                        flag: false,
                        flagFrom: "expenses",
                        categoryList: categoryList
                      );
                    }, icon: Icon(Icons.edit_note, color: Colors.green.shade700, size: 25,)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Divider(
                color: Colors.grey.shade300,
              ),
            ),
          ],
        );
      },
    );
  }
}
