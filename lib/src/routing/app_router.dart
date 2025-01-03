import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/src/features/favorites/presentation/favorites_screen.dart';
import 'package:movies_app/src/features/movies/presentation/movies/movies_search_screen.dart';
import 'package:movies_app/src/routing/scaffold_with_nested_navigation.dart';
import 'package:movies_app/src/splash_screen/splash_screen.dart';

enum AppRoute {
  movies,
  movie,
  favorites,
  splashScreen,
}

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _searchNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'search');
final _favoritesNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'favorites');

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splashScreen',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
          path: "/splashScreen",
          name: AppRoute.splashScreen.name,
          builder: (context, state) {
            return SplashScreen();
          }),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          // return SplashScreen();
          return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _searchNavigatorKey,
            routes: [
              // Products
              GoRoute(
                path: '/movies',
                name: AppRoute.movies.name,
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const MoviesSearchScreen(),
                ),
                routes: [],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _favoritesNavigatorKey,
            routes: [
              GoRoute(
                path: '/favorites',
                name: AppRoute.favorites.name,
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const FavoritesScreen(),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
