import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/src/features/movies/presentation/movies/movie_list_tile.dart';
import 'package:movies_app/src/features/movies/presentation/movies/movie_list_tile_shimmer.dart';
import 'package:movies_app/src/features/movies/presentation/movies/movies_search_bar.dart';
import 'package:movies_app/src/features/movies/provider/query_text_state_provider.dart';
import 'package:movies_app/src/response/get_movie_response.dart';
import 'package:movies_app/src/routing/app_router.dart';

class MoviesSearchScreen extends ConsumerStatefulWidget {
  const MoviesSearchScreen({super.key});

  static const pageSize = 20;

  @override
  ConsumerState<MoviesSearchScreen> createState() => _MoviesSearchScreenState();
}

class _MoviesSearchScreenState extends ConsumerState<MoviesSearchScreen> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      // When the user types, the query will be updated in Riverpod state.
    });
  }

  @override
  Widget build(BuildContext context) {
    final queryText =
        ref.watch(queryTextSearchController); // Watching query state

    // Get the first page of movies to retrieve the total number of results
    final responseAsync = ref.watch(getMovieResFutureProvider);

    print("query: $queryText");

    return Scaffold(
      appBar: AppBar(title: const Text('Movies')),
      body: Column(
        children: [
          MoviesSearchBar(
            movieController: searchController,
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(getMovieResFutureProvider);
              },
              child: responseAsync.when(
                data: (data) {
                  // Filter movies based on the search query
                  final filteredMovies = queryText.isEmpty
                      ? data // Show all movies if no query
                      : data.where((movie) {
                          return movie.title.toLowerCase().contains(
                              queryText.toLowerCase()); // Match by title
                        }).toList();

                  if (filteredMovies.isEmpty) {
                    // If no movies match the query, display "No results found"
                    return const Center(child: Text('No results found'));
                  }

                  return ListView.builder(
                    key: ValueKey(queryText),
                    itemCount: filteredMovies.length,
                    itemBuilder: (context, index) {
                      return MovieListTile(
                        movie: filteredMovies[index],
                        debugIndex: index + 1,
                        onPressed: () {
                          // Navigate to MovieDetailsScreen and pass the entire movie object
                          context.pushNamed(
                            AppRoute.movie.name,
                            extra: filteredMovies[
                                index], // Passing the movie object directly
                          );
                        },
                      );
                    },
                  );
                },
                error: (error, stackTrace) {
                  return MovieListTileError(
                    query: queryText,
                    page: 1,
                    indexInPage: 1,
                    error: error.toString(),
                    isLoading: responseAsync.isLoading,
                  );
                },
                loading: () {
                  return const MovieListTileShimmer();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MovieListTileError extends ConsumerWidget {
  const MovieListTileError({
    super.key,
    required this.query,
    required this.page,
    required this.indexInPage,
    required this.isLoading,
    required this.error,
  });

  final String query;
  final int page;
  final int indexInPage;
  final bool isLoading;
  final String error;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Only show error on the first item of the page
    return indexInPage == 0
        ? Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(error),
                ElevatedButton(
                  onPressed: isLoading ? null : () {},
                  child: const Text('Retry'),
                ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}
