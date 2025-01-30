import 'package:flutter/material.dart';
import 'package:movie_theater/models/movie.dart';
import 'package:movie_theater/presentation/pages/movie_page.dart';

// ignore: must_be_immutable
class MovieCard extends StatelessWidget {
  Movie movie;
  final List<Movie> allMovies; // Pass the list of all movies
  MovieCard({super.key, required this.movie, required this.allMovies});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MoviePage(movie: movie, allMovies: allMovies),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        width: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 215, 17, 17).withOpacity(0.3),
              blurRadius: 6,
              offset: const Offset(1, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            movie.poster,
            fit: BoxFit.cover,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                // Image is fully loaded
                return child;
              } else {
                // Show a loading indicator while the image is loading
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null, // Show indeterminate progress if total bytes are unknown
                    color: Colors.red, // Customize the loading indicator color
                  ),
                );
              }
            },
            errorBuilder: (BuildContext context, Object error,
                StackTrace? stackTrace) {
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
    );
  }
}