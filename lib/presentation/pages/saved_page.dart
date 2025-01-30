import 'package:flutter/material.dart';
import 'package:movie_theater/models/movie.dart';
import 'package:movie_theater/presentation/widgets/saved_movie_card.dart';
import 'package:movie_theater/provider/user_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SavedPage extends StatelessWidget {
  List<Movie> movies;
  SavedPage({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final savedMovies = userProvider.savedMovies;

    return Scaffold(
      backgroundColor: const Color(0xFF0D0B1E),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Saved Movies',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF0D0B1E),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and Subtitle
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                Center(
                  child: Text(
                    'Your cinematic treasures await! 🍿',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(height: 5),
              ],
            ),
          ),
          // List of Saved Movies or Empty State Message
          Expanded(
            child: savedMovies.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'No movies saved',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '"The only thing missing is popcorn... and a movie!" 🍿',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: savedMovies.length,
                    itemBuilder: (context, index) {
                      final movie = savedMovies[index];
                      return SavedMovieCard(movie: movie, movies: movies);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
