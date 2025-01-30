import 'package:flutter/material.dart';
import 'package:movie_theater/models/movie.dart';
import 'package:movie_theater/presentation/widgets/movie_card.dart';

Widget buildSimilarMoviesTab(Movie currentMovie, List<Movie> allMovies) {
  // Filter movies with the same genre
  final similarMovies = allMovies.where((movie) {
    return movie.genre.any((genre) => currentMovie.genre.contains(genre)) &&
           movie.title != currentMovie.title; // Exclude the current movie
  }).toList();

  return Padding(
    padding: const EdgeInsets.all( 16.0), // Space from the top
    child: GridView.builder(
      shrinkWrap: true, // Ensure the GridView doesn't take infinite height
      physics: const NeverScrollableScrollPhysics(), // Disable GridView's internal scrolling
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Two movies per row
        crossAxisSpacing: 16.0, // Space between columns
        mainAxisSpacing: 16.0, // Space between rows
        childAspectRatio: 0.7, // Adjust the aspect ratio of the cards
      ),
      itemCount: similarMovies.length,
      itemBuilder: (context, index) {
        final movie = similarMovies[index];
        return MovieCard(
          movie: movie,
          allMovies: allMovies,
        );
      },
    ),
  );
}