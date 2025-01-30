import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MovieContainer extends StatelessWidget {
  String imageUrl;
  String title;
  String description;
  String duration;
  String size;
  MovieContainer({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    this.duration = '0',
    this.size = '0',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Stack(
        children: [
          Row(
            children: [
              // Image Container
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl), // Replace with your asset
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12.0),
              // Text Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      description,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 10.0,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis ,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    duration != '0' ? Text(
                      "$duration | $size",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 9.0,
                      ),
                    ) : const SizedBox(height: 1,),
                  ],
                ),
              ),
            ],
          ),
          // Play Button Overlay
          Positioned(
            top: 30.0,
            left: 35.0,
            child: Icon(
              Icons.play_circle_outline_outlined,
              size: 30.0,
              color: const Color.fromARGB(91, 255, 255, 255).withOpacity(0.9),
            ),
          ),
          // Download Button
          Positioned(
            top: 8.0,
            right: 8.0,
            child: Icon(
              Icons.more_vert_outlined,
              color: Colors.white.withOpacity(0.8),
              size: 18.0,
            ),
          ),
        ],
      ),
    );
  }
}
