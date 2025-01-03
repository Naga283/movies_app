import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/src/response/response.dart';

class FavoriteMoviesNotifier extends ChangeNotifier {
  // List to store favorite movies
  List<MoviesList> _favoriteMovies = [];

  // Getter to access the favorite movies
  List<MoviesList> get favoriteMovies => _favoriteMovies;

  // Method to add a movie to the favorites list
  void toggleFavorite(MoviesList movie) {
    if (_favoriteMovies.contains(movie)) {
      // Remove the movie if it is already in the list
      _favoriteMovies.remove(movie);
    } else {
      // Add the movie if it is not in the list
      _favoriteMovies.add(movie);
    }
    // Notify listeners to rebuild UI
    notifyListeners();
  }
}

// The provider for managing favorite movies
final favoriteMoviesProvider =
    ChangeNotifierProvider<FavoriteMoviesNotifier>((ref) {
  return FavoriteMoviesNotifier();
});
