import 'package:dashboard/widgets/cardWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpensesScreen extends StatelessWidget {
  const ExpensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: MyAppBar(context),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 22),
        child: Column(
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
                  Text("8500 tk", style: TextStyle(
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
                          Text("80%", style: TextStyle(
                            fontWeight: FontWeight(700),
                            color: Colors.blue.shade700,
                          ),),
                          CircularProgressIndicator.adaptive(
                            strokeAlign: 3,
                            backgroundColor: Colors.blue.shade100,
                            strokeWidth: 5,
                            value: 0.8,
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
                  Cardwidget(text: "Food"),
                  Cardwidget(text: "Travel"),
                  Cardwidget(text: "Bills"),
                  Cardwidget(text: "Shopping"),
                ],
              ),
            ),
          ],
        ),
      ),
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
