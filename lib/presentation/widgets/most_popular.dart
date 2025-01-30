import 'package:flutter/material.dart';
import 'package:movie_theater/models/movie.dart';
import 'package:movie_theater/presentation/pages/see_all.dart';
import 'package:movie_theater/presentation/widgets/movie_card.dart';
import 'package:movie_theater/services/api_service.dart';

class MostPopularSection extends StatefulWidget {
  const MostPopularSection({super.key});

  @override
  State<MostPopularSection> createState() => _MostPopularSectionState();
}

class _MostPopularSectionState extends State<MostPopularSection> {
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
          return const Center(
            child: CircularProgressIndicator(),
          );
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
          movies.sort((a, b) => b.rating.compareTo(a.rating));

          // Take the top 6 movies
          final topMovies = movies.take(6).toList();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Most Popular",
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
                  children: topMovies
                      .map((movie) => MovieCard(
                            movie: movie,
                            allMovies: movies,
                          ))
                      .toList(),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
