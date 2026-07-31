import 'package:dashboard/screens/home_screen.dart';
import 'package:dashboard/screens/note_screen.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  GoRouter appRoute = GoRouter(
    initialLocation: "note",
      routes: [
        GoRoute(
          path: "/",
          name: "home",
          builder: (context, state) => HomeScreen(),
        ),
        GoRoute(
          path: "/note",
          name: "note",
          builder: (context, state) => NoteScreen(),
        ),
      ],
  );
}