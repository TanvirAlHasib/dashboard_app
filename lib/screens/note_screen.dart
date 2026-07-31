import 'package:dashboard/widgets/cardWidget.dart';
import 'package:dashboard/widgets/floatingActionButtonWidget.dart';
import 'package:dashboard/widgets/textFormFieldWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoteScreen extends StatelessWidget {
  NoteScreen({super.key});

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: MyAppBar(context),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Textformfieldwidget(hintText: "Search notes...", icon: CupertinoIcons.search),

            const SizedBox(
              height: 20,
            ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: 2,
                children: [
                  InkWell(child: Cardwidget(text: "All Notes")),
                  InkWell(child: Cardwidget(text: "Work")),
                  InkWell(child: Cardwidget(text: "Personal")),
                  InkWell(child: Cardwidget(text: "Ideas")),
                ],
              ),
            ),

            const SizedBox(
              height: 25,
            ),

            Container(
              padding: EdgeInsets.all(15),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Colors.grey.shade300,
                  strokeAlign: BorderSide.strokeAlignOutside
                )
              ),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Card(
                        color: Theme.of(context).cardColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
                          child: Text("May, 10", style: TextStyle(
                              fontSize: 13
                          ),
                          ),
                        ),
                      ),
                      Card(
                        color: Theme.of(context).cardColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                          child: Text("Work", style: TextStyle(
                            fontSize: 13,
                            color: Colors.green,
                            fontWeight: FontWeight(600)
                          ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Client Meeting Notes", style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight(600)
                  ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("Client requested an updated timeline by Wednesday. They prefer a darker color palette for the next iteration of the prototype.",
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.delete_forever_outlined, color: Colors.red, size: 34,)
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.edit_note_outlined, color: Colors.green.shade500, size: 34,)
                      ),
                    ],
                  ),
                ],
              ),
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
      title: Text("Notes", style: TextStyle(
        //fontWeight: FontWeight(600),
        fontSize: 19,
      ),
      ),
    );
  }
}
