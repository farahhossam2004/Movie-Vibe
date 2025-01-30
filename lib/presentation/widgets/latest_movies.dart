import 'package:flutter/material.dart';
import 'package:movie_theater/models/movie.dart';
import 'package:movie_theater/presentation/pages/see_all.dart';
import 'package:movie_theater/presentation/widgets/movie_card.dart';
import 'package:movie_theater/services/api_service.dart';

class LatestMovies extends StatefulWidget {
  const LatestMovies({super.key});

  @override
  State<LatestMovies> createState() => _LatestMoviesState();
}

class _LatestMoviesState extends State<LatestMovies> {
  late Future<List<Movie>> futureMovies;

  @override
  void initState() {
    super.initState();
    futureMovies = ApiService.getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Movie>>(
      future: futureMovies,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No movies found'),
          );
        } else {
          final movies = snapshot.data!;
          movies.sort((a, b) => b.year.compareTo(a.year));

          // Take the latest 6 movies
          final latestMovies = movies.take(6).toList();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Latest Movies",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SeeAll(allMovies: movies)));
                    },
                    child: const Text(
                      "See all",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 180,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: latestMovies.map((movie) => MovieCard(movie: movie, allMovies: movies,)).toList(),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
