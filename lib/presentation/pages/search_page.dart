import 'package:flutter/material.dart';
import 'package:movie_theater/models/movie.dart';
import 'package:movie_theater/presentation/widgets/movie_card.dart';
import 'package:movie_theater/services/api_service.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Movie> searchResults = [];
  bool isLoading = false;

  void _searchMovies(String query) async {
    setState(() {
      isLoading = true;
    });

    try {
      final results = await ApiService.searchMovies(query);
      setState(() {
        searchResults = results;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0B1E),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(75, 29, 25, 68),
        title: const Center(
            child: Text(
          'Search Movies',
          style: TextStyle(color: Colors.white, fontSize: 20),
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for movies...',
                hintStyle: const TextStyle(fontSize: 14, color: Colors.grey), // Hint text color
                prefixIcon: const Icon(Icons.search, color: Colors.grey), // Search icon color
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear, color: Colors.grey), // Clear icon color
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      searchResults.clear();
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide.none, // Remove the border
                ),
                filled: true,
                fillColor: const Color(0xFF1C1A2E), // Set the background color of the search box
              ),
              style: const TextStyle(color: Colors.white), // Text color
              onChanged: (query) {
                if (query.isNotEmpty) {
                  _searchMovies(query);
                } else {
                  setState(() {
                    searchResults.clear();
                  });
                }
              },
            ),
            const SizedBox(height: 20),

            // Search Results
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : searchResults.isEmpty
                    ? const Center(
                        child: Text(
                          'No movies found ;(',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      )
                    : Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // Number of columns in the grid
                            crossAxisSpacing: 10, // Spacing between columns
                            mainAxisSpacing: 10, // Spacing between rows
                            childAspectRatio: 0.7, // Aspect ratio of each item
                          ),
                          itemCount: searchResults.length,
                          itemBuilder: (context, index) {
                            final movie = searchResults[index];
                            return MovieCard(
                              movie: movie,
                              allMovies:
                                  searchResults, // Pass the list of all movies
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