import 'package:flutter/material.dart';
import 'package:movie_theater/models/movie.dart';
import 'package:movie_theater/presentation/widgets/movie_card.dart';

// ignore: must_be_immutable
class SeeAll extends StatelessWidget {
  List<Movie> allMovies;

  SeeAll({super.key, required this.allMovies});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0B1E),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 13, 11, 30), 
        iconTheme: const IconThemeData(color: Colors.white), // Set back button color to white
        title: const Text(
          'View All',
          style: TextStyle(color: Colors.white, fontSize: 16),)
      ),
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
                itemCount: allMovies.length,
                itemBuilder: (context, index) {
                  final movie = allMovies[index];
                  return MovieCard(
                    movie: movie,
                    allMovies: allMovies,
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
