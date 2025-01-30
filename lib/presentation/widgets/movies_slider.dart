import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_theater/models/movie.dart';
import 'package:movie_theater/services/api_service.dart';

class MoviesSlider extends StatefulWidget {
  const MoviesSlider({super.key});

  @override
  State<MoviesSlider> createState() => _MoviesSliderState();
}

class _MoviesSliderState extends State<MoviesSlider> {
  int _currentIndex = 0; // To keep track of the current image index
  late Future<List<Movie>> futureMovies;

  @override
  void initState() {
    super.initState();
    futureMovies = ApiService.getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
            final movies = snapshot.data!.take(5).toList();
            return Column(
              children: [
                CarouselSlider(
                  items: movies
                      .map((movie) => Image.network(
                            movie.poster,
                            fit: BoxFit.fill,
                            width: double.infinity,
                          ))
                      .toList(),
                  options: CarouselOptions(
                    height: 250.0,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 0.9,
                    aspectRatio: 16 / 9,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index; // Update the current index
                      });
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: movies.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => setState(() {
                        _currentIndex = entry.key;
                      }),
                      child: Container(
                        width: 8.0,
                        height: 8.0,
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentIndex == entry.key
                              ? Colors.red
                              : Colors.grey,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            );
          }
        });
  }
}
