import 'package:flutter/material.dart';
import 'package:movie_theater/models/movie.dart'; 
import 'package:movie_theater/presentation/pages/category.dart';


class Categories extends StatelessWidget {
  final List<Movie> movies; // Add a list of movies to the constructor

  const Categories({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Categories",
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            fontFamily: "CustomFont",
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 30,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildCategoryButton(context, "All", true),
              _buildCategoryButton(context, "Action", false),
              _buildCategoryButton(context, "Romance", false),
              _buildCategoryButton(context, "Drama", false),
              _buildCategoryButton(context, "Sci-Fi", false),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryButton(BuildContext context, String label, bool isSelected) {
    return GestureDetector(
      onTap: () {
        // Navigate to the Category page when a button is pressed
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Category(
              categoryName: label, // Pass the category name
              movies: movies, // Pass the list of movies
            ),
          ),
        );
      },
      child: Container(
        width: 70,
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.red : const Color(0xFF1D1B30),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey,
              fontSize: 10,
            ),
          ),
        ),
      ),
    );
  }
}
