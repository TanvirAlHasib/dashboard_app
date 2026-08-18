import 'package:dashboard/screens/expenses_screen.dart';
import 'package:dashboard/screens/home_screen.dart';
import 'package:dashboard/screens/note_screen.dart';
import 'package:dashboard/screens/task_screen.dart';
import 'package:dashboard/utils/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

GoRouter appRoute = GoRouter(
    initialLocation: "/",
      routes: [
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return AppShell(navigationShell: navigationShell,);
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

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(builder: (context, value, child) {
      return PopScope(
        canPop: value.history.length <= 1,
        onPopInvokedWithResult: (didPop, result) {
          if(!didPop){
            value.handleBack(context, navigationShell);
          }
        },
        child: Scaffold(
          body: navigationShell,
          bottomNavigationBar: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30))
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent,
              showUnselectedLabels: false,
              unselectedItemColor: Colors.blue.shade500,
              selectedLabelStyle: TextStyle(
                  fontWeight: FontWeight(600)
              ),
              currentIndex: navigationShell.currentIndex,
              selectedItemColor: Colors.blue.shade900,
              elevation: 0,
              onTap: (index) => value.onAdd(index, context, navigationShell),
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
        ),
      );
    },);
  }
}
