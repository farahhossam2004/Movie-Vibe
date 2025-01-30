import 'package:flutter/material.dart';
import 'package:movie_theater/models/movie.dart';
import 'package:movie_theater/presentation/pages/movie_page.dart';
import 'package:movie_theater/provider/user_provider.dart';
import 'package:provider/provider.dart';

class SavedMovieCard extends StatelessWidget {
  final Movie movie;
  final List<Movie> movies;

  const SavedMovieCard({super.key, required this.movie, required this.movies});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1A2E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Movie Poster with Loading Indicator
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MoviePage(movie: movie, allMovies: movies),
                ),
              );
            },
            child: Container(
              width: 80,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  movie.poster,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      // Image is fully loaded
                      return child;
                    } else {
                      // Show a loading indicator while the image is loading
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                              : null, // Show indeterminate progress if total bytes are unknown
                          color: Colors.red, // Customize the loading indicator color
                        ),
                      );
                    }
                  },
                  errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                    // Show an error widget if the image fails to load
                    return const Center(
                      child: Icon(
                        Icons.error,
                        color: Colors.red,
                        size: 40,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Movie Title and Genre List
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4), // Add some spacing between title and genre list
                Text(
                  '${movie.genre.join(", ")}',
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                ),
              ],
            ),
          ),
          // Bookmark Icon
          IconButton(
            icon: const Icon(
              Icons.bookmark_remove,
              color: Colors.red,
            ),
            onPressed: () {
              userProvider.removeSavedMovie(movie);
            },
          ),
        ],
      ),
    );
  }
}