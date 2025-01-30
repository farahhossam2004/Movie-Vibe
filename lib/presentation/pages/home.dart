// lib/presentation/pages/home.dart
import 'package:flutter/material.dart';
import 'package:movie_theater/models/movie.dart';
import 'package:movie_theater/presentation/pages/downloads.dart';
import 'package:movie_theater/presentation/pages/profile_page.dart';
import 'package:movie_theater/presentation/pages/saved_page.dart';
import 'package:movie_theater/presentation/pages/search_page.dart';
import 'package:movie_theater/presentation/widgets/categories.dart';
import 'package:movie_theater/presentation/widgets/latest_movies.dart';
import 'package:movie_theater/presentation/widgets/most_popular.dart';
import 'package:movie_theater/presentation/widgets/movies_slider.dart';
import 'package:movie_theater/presentation/widgets/nav_bottom_bar.dart';
import 'package:movie_theater/services/api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;
  late Future<List<Movie>> futureMovies;

  @override
  void initState() {
    super.initState();
    futureMovies = ApiService.getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0B1E),
      body: FutureBuilder<List<Movie>>(
        future: futureMovies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No movies found'));
          } else {
            final movies = snapshot.data!;

            // Update the home page with the fetched movies
            final homePage = SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MoviesSlider(), // Pass movies to MoviesSlider
                    const SizedBox(height: 20.0),
                    Categories(movies: movies), // Pass movies to Categories
                    const SizedBox(height: 20.0),
                    MostPopularSection(), // Pass movies to MostPopularSection
                    const SizedBox(height: 20.0),
                    LatestMovies(), // Pass movies to LatestMovies
                  ],
                ),
              ),
            );

            // Define the pages
            final List<Widget> pages = [
              homePage,
              const SearchPage(),
              SavedPage(movies: movies),
              // const Center(
              //   child: Text(
              //     'Saved Page',
              //     style: TextStyle(color: Colors.white, fontSize: 18),
              //   ),
              // ),
              const DownloadsPage(),
              const ProfilePage()
            ];

            return pages[currentPageIndex];
          }
        },
      ),
      bottomNavigationBar: NavBottomBar(
        currentIndex: currentPageIndex,
        onTap: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
      ),
    );
  }
}
