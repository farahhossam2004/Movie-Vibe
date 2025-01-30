import 'package:flutter/material.dart';
import 'package:movie_theater/models/movie.dart';

// ignore: camel_case_types
class aboutSection extends StatelessWidget {
  const aboutSection({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(child: Text('About this movie', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white70),),),
          const SizedBox(height: 20,),
          // Year
          Text(
            '🎞️ Year:     ${movie.year}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Divider(thickness:1, indent: 50, endIndent: 50, color: Colors.red),
    
          // Rating
          Text(
            '🌟 Rating:    ${movie.rating}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Divider(thickness:1, indent: 50, endIndent: 50, color: Colors.red,),
    
          // Actors
          const Text(
            '🎭 Actors:',
            style:TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: movie.actors
                .map(
                  (actor) => Text(
                    '⚪ $actor',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 10),
          const Divider(thickness:1, indent: 50, endIndent: 50, color: Colors.red,),
          Text(
            '🎬 Director:    ${movie.director}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}