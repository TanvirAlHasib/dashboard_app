import 'package:dashboard/utils/expense_provider.dart';
import 'package:dashboard/utils/provider_state_management.dart';
import 'package:dashboard/utils/task_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../utils/navigation_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: MyAppBar(context),
      body: Container(
        padding: const EdgeInsets.all(17),
        child: Column(
          crossAxisAlignment: .start,
          spacing: 15,
          children: [
            Text("Quick Actions", style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight(600)
            ),),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: 5,
                children: [
                  getQuickActions(actionName: "Add Note", icon: Icons.sticky_note_2_sharp, action: () {
                    final navigationShell = StatefulNavigationShell.of(context);
                    context.read<NavigationProvider>().onAdd(1, context, navigationShell);
                  },),
                  getQuickActions(actionName: "Add Task", icon: Icons.add_task, action: () {
                    final navigationShell = StatefulNavigationShell.of(context);
                    context.read<NavigationProvider>().onAdd(2, context, navigationShell);
                  },),
                  getQuickActions(actionName: "Add Expense", icon: Icons.money, action: () {
                    final navigationShell = StatefulNavigationShell.of(context);
                    context.read<NavigationProvider>().onAdd(3, context, navigationShell);
                  },)
                ],
              ),
            ),
            Text("Dashboard Info", style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight(600)
            ),),
            Row(
              spacing: 5,
              children: [
                getTaskNoteInfo(info: "${context.watch<TaskProvider>().taskList.length - TaskProvider.completedTask}", title: "Today's Task", icon: Icons.add_task, subTitle: "remaining"),
                getTaskNoteInfo(info: "${context.watch<ProviderStateManagement>().getNoteList.length}", title: "Quick Notes", icon: Icons.sticky_note_2_sharp, subTitle: "in total"),
              ],
            ),
            Card(
              color: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(side: BorderSide(
                  color: Colors.blue.shade200
              ), borderRadius: BorderRadiusGeometry.circular(10)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Row(
                  spacing: 12,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blue.shade50,
                      maxRadius: 25,
                      child: Icon(Icons.money, color: Colors.blue.shade800,),
                    ),
                    Column(
                      spacing: 1,
                      crossAxisAlignment: .start,
                      children: [
                        Text("Monthly Expenses", style: TextStyle(
                          fontSize: 16,
                        ),),
                        Row(
                          spacing: 8,
                          children: [
                            Text("${context.watch<ExpenseProvider>().totalSpent}", style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight(600)
                            ),),
                            Text("taka spent")
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // appbar starts here
  AppBar MyAppBar(BuildContext context){
    return AppBar(
      backgroundColor: Theme.of(context).cardColor,
      elevation: 3,
      centerTitle: true,
      title: Text("Dashboard", style: TextStyle(
        //fontWeight: FontWeight(600),
        fontSize: 19,
      ),
      ),
    );
  }

  // Quick action event
  Widget getQuickActions({required String actionName, required IconData icon, required Function action}){
    return InkWell(
      onTap: () {
        action();
      },
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(side: BorderSide(
          color: Colors.blue.shade200,
        ), borderRadius: BorderRadiusGeometry.circular(10)),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 9.0, horizontal: 20),
          child: Column(
            spacing: 6,
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue.shade50,
                maxRadius: 25,
                child: Icon(icon, color: Colors.blue.shade800,),
              ),
              Text(actionName, style: TextStyle(
                  fontWeight: FontWeight(500)
              ),)
            ],
          ),
        ),
      ),
    );
  }

  // get task and note info
  Widget getTaskNoteInfo({required String info, required String title, required IconData icon, required String subTitle}){
    return Expanded(
      child: Card(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(side: BorderSide(
            color: Colors.blue.shade200
        ), borderRadius: BorderRadiusGeometry.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 9.0, horizontal: 20),
          child: Column(
            crossAxisAlignment: .start,
            spacing: 5,
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue.shade50,
                maxRadius: 25,
                child: Icon(icon, color: Colors.blue.shade800,),
              ),
              const SizedBox(
                height: 1,
              ),
              Text(title, style: TextStyle(
                fontSize: 16,
              ),),
              Row(
                mainAxisSize: .min,
                spacing: 8,
                children: [
                  Text(info, style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight(600)
                  ),),
                  Text(subTitle,)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}