import 'package:dashboard/widgets/floatingActionButtonWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskScreen extends StatelessWidget {
  TaskScreen({super.key});

  bool checkBoxValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: MyAppBar(context),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 22),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(17),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color(0XFFE5EEFF),
              ),
              child: Row(
                spacing: 25,
                children: [
                  Stack(
                    alignment: AlignmentGeometry.center,
                    children: [
                      Text(
                        "40%",
                        style: TextStyle(
                          color: Colors.blue.shade900,
                          fontWeight: FontWeight(600),
                        ),
                      ),
                      CircularProgressIndicator.adaptive(
                        padding: EdgeInsets.only(bottom: 10,right: 10, top: 10, left: 15),
                        value: 0.4,
                        strokeAlign: 4,
                        strokeWidth: 6,
                        backgroundColor: Colors.blue.shade100,
                        valueColor: AlwaysStoppedAnimation(Colors.blue.shade700),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text(
                        "4/10",
                        style: TextStyle(
                          fontWeight: FontWeight(500),
                          fontSize: 21,
                        ),
                      ),
                      Text(
                        "Tasks completed",
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            Row(
              spacing: 13,
              children: [
                Icon(Icons.calendar_month, color: Colors.blue.shade800,),
                Text(
                  "Today's Tasks",
                  style: TextStyle(
                    fontWeight: FontWeight(500),
                    fontSize: 20
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            // starts task here
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0XFFE5EEFF)
              ),
              child: ListTile(
                leading: Checkbox.adaptive(value: checkBoxValue, onChanged: (value) {
                  checkBoxValue = value!;
                },),
                title: Text("Review Q3 Financial Reports", style: TextStyle(
                  height: 2,
                  fontWeight: FontWeight(500)
                ),),
                horizontalTitleGap: 4,
                subtitle: Column(
                  spacing: 10,
                  children: [
                    Text("Check discrepancies in the marketing budget before the 2 PM meeting."),
                    Row(
                      spacing: 7,
                      children: [
                        Icon(CupertinoIcons.clock, size: 15, color: Colors.grey.shade600,),
                        Text("2.00 PM", style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12
                        ),)
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      floatingActionButton: Floatingactionbuttonwidget(),
    );
  }

  // appbar starts here
  AppBar MyAppBar(BuildContext context){
    return AppBar(
      backgroundColor: Theme.of(context).cardColor,
      elevation: 3,
      centerTitle: true,
      title: Text("Task", style: TextStyle(
        //fontWeight: FontWeight(600),
        fontSize: 19,
      ),
      ),
    );
  }
}
