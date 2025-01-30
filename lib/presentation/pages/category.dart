import 'package:flutter/material.dart';
import 'package:movie_theater/models/movie.dart';
import 'package:movie_theater/presentation/widgets/movie_card.dart';

// ignore: must_be_immutable
class Category extends StatelessWidget {
  List<Movie> movies;
  String categoryName;
  Category({super.key, required this.categoryName, required this.movies});

  @override
  Widget build(BuildContext context) {
    final List<Movie> filteredMovies;
    if (categoryName == "All") {
      filteredMovies = movies;
    } else {
      filteredMovies = movies.where((movie) {
        return movie.genre.contains(
            categoryName); // Check if the movie belongs to the category
      }).toList();
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0D0B1E),
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(0, 13, 11, 30),
          iconTheme: const IconThemeData(
              color: Colors.white), // Set back button color to white
          title: Text(
            categoryName,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0), // Space from the top
              child: GridView.builder(
                shrinkWrap:
                    true, // Ensure the GridView doesn't take infinite height
                physics:
                    const NeverScrollableScrollPhysics(), // Disable GridView's internal scrolling
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Two movies per row
                  crossAxisSpacing: 16.0, // Space between columns
                  mainAxisSpacing: 16.0, // Space between rows
                  childAspectRatio: 0.7, // Adjust the aspect ratio of the cards
                ),
                itemCount: filteredMovies.length,
                itemBuilder: (context, index) {
                  final movie = filteredMovies[index];
                  return MovieCard(
                    movie: movie,
                    allMovies: movies,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
