import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: MyAppBar(context),
      body: Container(
        padding: const EdgeInsets.all(13),
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
      title: Text("Task", style: TextStyle(
        //fontWeight: FontWeight(600),
        fontSize: 19,
      ),
      ),
    );
  }
}
