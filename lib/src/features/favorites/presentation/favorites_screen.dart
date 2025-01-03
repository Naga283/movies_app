import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/src/features/movies/presentation/movies/movie_list_tile.dart';
import 'package:movies_app/src/response/favaorite_movie_change_notifier_provider.dart';
import 'package:movies_app/src/routing/app_router.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to the favoriteMoviesProvider
    final favoriteMovies = ref.watch(favoriteMoviesProvider).favoriteMovies;

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: favoriteMovies.isEmpty
          ? const Center(child: Text("No Favorites Yet"))
          : ListView.builder(
              itemCount: favoriteMovies.length,
              itemBuilder: (context, index) {
                final movie = favoriteMovies[index];
                return MovieListTile(
                  movie: movie,
                  onPressed: () {
                    context.pushNamed(
                      AppRoute.movie.name,
                      extra: movie, // Passing the movie object directly
                    );
                  },
                );
              },
            ),
    );
  }
}
