import 'package:dashboard/screens/expenses_screen.dart';
import 'package:dashboard/screens/home_screen.dart';
import 'package:dashboard/screens/note_screen.dart';
import 'package:dashboard/screens/task_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
   GoRouter appRoute = GoRouter(
    initialLocation: "/",
      routes: [
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return Scaffold(
              body: navigationShell,
              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(8), topLeft: Radius.circular(8))
                ),
                child: BottomNavigationBar(
                  backgroundColor: Colors.transparent,
                  unselectedItemColor: Colors.blue.shade500,
                  selectedLabelStyle: TextStyle(
                    fontWeight: FontWeight(600)
                  ),
                  currentIndex: navigationShell.currentIndex,
                  selectedItemColor: Colors.blue.shade900,
                  elevation: 3,
                  onTap: (index) => navigationShell.goBranch(index),
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.dashboard_outlined,),
                      activeIcon: Icon(Icons.dashboard),
                      label: "Home",
                    ),

                    BottomNavigationBarItem(
                        icon: Icon(Icons.sticky_note_2_outlined,),
                        activeIcon: Icon(Icons.sticky_note_2),
                        label: "Note"
                    ),

                    BottomNavigationBarItem(
                      icon: Icon(Icons.add_task_outlined,),
                      activeIcon: Icon(Icons.add_task),
                      label: "Task"
                    ),

                    BottomNavigationBarItem(
                      icon: Icon(Icons.money_outlined,),
                      activeIcon: Icon(Icons.money),
                      label: "Expenses"
                    ),
                  ],
                ),
              ),
            );
          },
          branches: [
            StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: "/",
                    name: "home",
                    builder: (context, state) => HomeScreen(),
                  ),
                ]
            ),

            StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: "/note",
                    name: "note",
                    builder: (context, state) => NoteScreen(),
                  ),
                ]
            ),

            StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: "/task",
                    name: "task",
                    builder: (context, state) => TaskScreen(),
                  ),
                ]
            ),

            StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: "/expenses",
                    name: "expenses",
                    builder: (context, state) => ExpensesScreen(),
                  ),
                ]
            )
          ],
        ),
      ],
  );
}