import 'package:flutter/material.dart';
import 'package:movies_app/src/common_widgets/movie_poster.dart';
import 'package:movies_app/src/common_widgets/top_gradient.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/src/features/favorites/provider/favaorite_movie_change_notifier_provider.dart';
import 'package:movies_app/src/response/response.dart'; // import the notifier

class MovieListTile extends ConsumerWidget {
  const MovieListTile({
    super.key,
    required this.movie,
    this.debugIndex,
    this.onPressed,
  });

  final MoviesList movie;
  final int? debugIndex;
  final VoidCallback? onPressed;

  static const posterHeight = 80.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Access the favoriteMoviesNotifier from Riverpod
    final favoriteMoviesNotifier = ref.watch(favoriteMoviesProvider);

    // Check if this movie is in the favorites list
    final isFavorite = favoriteMoviesNotifier.favoriteMovies.contains(movie);

    // Toggle favorite when the icon is clicked
    void toggleFavorite() {
      favoriteMoviesNotifier.toggleFavorite(movie);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: onPressed,
            child: Stack(
              children: [
                SizedBox(
                  width: posterHeight * MoviePoster.width / MoviePoster.height,
                  height: posterHeight,
                  child: MoviePoster(imagePath: movie.posterUrl),
                ),
                if (debugIndex != null) ...[
                  const Positioned.fill(child: TopGradient()),
                  Positioned(
                    left: 4,
                    top: 4,
                    child: Text(
                      '$debugIndex',
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ]
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  "IMDB ID: ${movie.imdbId}",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : null,
            ),
            onPressed: toggleFavorite,
          ),
        ],
      ),
    );
  }
}
