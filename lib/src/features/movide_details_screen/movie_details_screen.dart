import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/src/common_widgets/movie_poster.dart';
import 'package:movies_app/src/response/favaorite_movie_change_notifier_provider.dart';
import 'package:movies_app/src/response/response.dart'; // Import the provider

class MovieDetailsScreen extends ConsumerWidget {
  final MoviesList movie;

  const MovieDetailsScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Access the favorite movie list from the provider
    final favoriteMovies = ref.watch(favoriteMoviesProvider);

    // Check if the movie is a favorite
    final isFavorite = favoriteMovies.favoriteMovies.contains(movie);

    // Function to toggle the favorite state
    void toggleFavorite() {
      ref.read(favoriteMoviesProvider.notifier).toggleFavorite(movie);
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(movie.title),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : null,
            ),
            onPressed: toggleFavorite,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Movie Poster
              SizedBox(
                height: 250,
                child: MoviePoster(imagePath: movie.posterUrl),
              ),
              const SizedBox(height: 16),
              // Movie Title
              Text(
                movie.title,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 8),
              Text(
                "Imdb Id: ${movie.imdbId}",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
