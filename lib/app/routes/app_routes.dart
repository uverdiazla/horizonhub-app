import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';


/// Configuration of the app routes using GoRouter.
/// Defines navigation paths and how pages are connected.
class AppRoutes {
  // Define the router and its routes
  static final GoRouter router = GoRouter(
    routes: [
      // Route for the comic list page (home page)
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => Container(),
      ),
      // Dynamic route for the comic detail page, passing comic ID as parameter
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) {
          return Container();
        },
      ),
    ],
  );
}
