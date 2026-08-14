import 'package:dashboard/models/budget_model.dart';
import 'package:dashboard/models/expense_model.dart';
import 'package:dashboard/utils/expense_provider.dart';
import 'package:dashboard/utils/toast.dart';
import 'package:dashboard/widgets/cardWidget.dart';
import 'package:dashboard/widgets/floatingActionButtonWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpensesScreen extends StatelessWidget {
  ExpensesScreen({super.key});

  bool canAccess = true;

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
            if(expenseList.isEmpty){
              return Center(
                child: Text("No Expenses yet"),
              );
            }

            if(budgetList.isEmpty){
              //Toast(context).show("Please enter this month's budget!!", () {},);
              canAccess = false;
              return SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: .center,
                  mainAxisAlignment: .center,
                  spacing: 8,
                  children: [
                    Text("Budget is empty for this month"),
                    FilledButton(
                      onPressed: (){ },
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.blue.shade800,
                      ),
                      child: Text("History", style: TextStyle(
                        fontWeight: FontWeight(600)
                      ),))
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
                              Text("${((ExpenseProvider.totalSpent / budgetList[0].budget) * 100 ).toInt()}%",
                                style: TextStyle(
                                fontWeight: FontWeight(700),
                                color: Colors.blue.shade700,
                              ),),
                              CircularProgressIndicator.adaptive(
                                strokeAlign: 3,
                                backgroundColor: Colors.blue.shade100,
                                strokeWidth: 5,
                                value: (ExpenseProvider.totalSpent / budgetList[0].budget),
                                valueColor: AlwaysStoppedAnimation(Colors.blue.shade700),
                              )
                            ],
                          ),
                          Text("used of your total budget", style: TextStyle(
                              color: Colors.grey.shade700
                          ),)
                        ],
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
                          onTap: () { },
                          child: Cardwidget(text: "Food")
                      ),
                      InkWell(
                          onTap: () { },
                          child: Cardwidget(text: "Travel")
                      ),
                      InkWell(
                          onTap: () { },
                          child: Cardwidget(text: "Bills")
                      ),
                      InkWell(
                          onTap: () { },
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
                  child: ListView.builder(
                    itemCount: expenseList.length,
                    itemBuilder: (context, index) {
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
                                  IconButton(onPressed: () { }, icon: Icon(Icons.delete, color: Colors.red.shade700, size: 23,)),
                                  IconButton(onPressed: () { }, icon: Icon(Icons.edit_note, color: Colors.green.shade700, size: 25,)),
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
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: canAccess ? Floatingactionbuttonwidget(flagFrom: "expenses") : null,
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
}
