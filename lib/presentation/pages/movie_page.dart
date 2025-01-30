import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:movie_theater/models/movie.dart';
import 'package:movie_theater/presentation/widgets/about_section.dart';
import 'package:movie_theater/presentation/widgets/simillar_movie.dart';
import 'package:movie_theater/provider/user_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/movie_container.dart';

class MoviePage extends StatefulWidget {
  final Movie movie;
  final List<Movie> allMovies; // Pass the list of all movies
  const MoviePage({super.key, required this.movie, required this.allMovies});

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  bool isBookmarked = false;

  void _toggleBookmark() {
  final userProvider = Provider.of<UserProvider>(context, listen: false);
  if (isBookmarked) {
    userProvider.removeSavedMovie(widget.movie); // Remove from saved list
  } else {
    userProvider.addSavedMovie(widget.movie); // Add to saved list
  }
  setState(() {
    isBookmarked = !isBookmarked; // Toggle the bookmark state
  });
}

@override
void initState() {
  super.initState();
  final userProvider = Provider.of<UserProvider>(context, listen: false);
  isBookmarked = userProvider.isMovieSaved(widget.movie); // Initialize bookmark state
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0B1E),
      body: Stack(
        children: [
          // Main content (scrollable)
          SingleChildScrollView(
            child: Column(
              children: [
                // Image with ShaderMask
                SizedBox(
                  width: double.infinity, // Takes full width
                  height: 250, // Height of the image
                  child: ShaderMask(
                    shaderCallback: (rect) {
                      return const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromARGB(107, 253, 15,
                              15), // Top of the image stays visible
                          Color.fromARGB(
                              206, 229, 22, 22), // Bottom fades into black
                        ],
                      ).createShader(
                          Rect.fromLTRB(0, 0, rect.width, rect.height));
                    },
                    blendMode: BlendMode.dstIn, // Fades the image
                    child: Image.network(
                      widget.movie.poster,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Title
                Text(
                  widget.movie.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),

                // Subtitle
                Text(
                  '${widget.movie.year}  .  ${widget.movie.genre.join(", ")}  .  ${widget.movie.language}', // Join all genres
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                ),
                const SizedBox(height: 10),

                // Buttons (Play and Download)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Play Button
                    ElevatedButton.icon(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        minimumSize: const Size(130, 30),
                      ),
                      icon: const Icon(Icons.play_arrow_rounded,
                          size: 18, color: Colors.white),
                      label: const Text(
                        'Play',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),

                    // Download Button
                    ElevatedButton.icon(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 32, 28, 59),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        minimumSize: const Size(120, 30), // Width and height
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10), // Inner padding
                      ),
                      icon: const Icon(Icons.play_for_work_rounded,
                          size: 18, color: Colors.white),
                      label: const Text(
                        'Download',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Expandable Text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ExpandableText(
                    widget.movie.plot,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w300,
                    ),
                    maxLines: 3,
                    expandText: 'Read More',
                    collapseText: 'Show Less',
                    linkColor: Colors.red,
                    linkStyle: const TextStyle(fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 10),

                // Tab Bar Section
                DefaultTabController(
                  length: 3,
                  child: Column(
                    children: [
                      const TabBar(
                        labelStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        labelColor: Colors.red,
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: Colors.red,
                        dividerHeight: 0.2,
                        indicatorWeight: 1,
                        tabs: [
                          Tab(text: 'Episode'),
                          Tab(text: 'Similar'),
                          Tab(text: 'About'),
                        ],
                      ),
                      // Make the TabBarView scrollable
                      SizedBox(
                        height: MediaQuery.of(context).size.height *
                            0.6, // Adjust height as needed
                        child: TabBarView(
                          children: [
                            // Episode Tab Content
                            SingleChildScrollView(
                              child: MovieContainer(
                                imageUrl: widget.movie.poster,
                                description: widget.movie.plot,
                                title: 'Trailer',
                              ),
                            ),
                            // Similar Tab Content
                            SingleChildScrollView(
                              child: buildSimilarMoviesTab(
                                  widget.movie, widget.allMovies),
                            ),
                            // About Tab Content
                            SingleChildScrollView(
                              child: aboutSection(movie: widget.movie),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Back Button
          Positioned(
            top: 30, // Adjust based on your design
            left: 10,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              iconSize: 24,
            ),
          ),
          Positioned(
            top: 30,
            right: 10,
            child: IconButton(
              highlightColor: Colors.red,
              icon: Icon(
                isBookmarked
                    ? Icons.bookmark_added
                    : Icons.bookmark_add_outlined,
                color: Colors.white,
              ),
              onPressed: _toggleBookmark,
            ),
          ),
        ],
      ),
    );
  }
}

// class MovieTrailer extends StatelessWidget {
//   const MovieTrailer({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.all(16.0),
//       padding: const EdgeInsets.all(8.0),
//       decoration: BoxDecoration(
//         color: const Color(0xFF1A1A2E),
//         borderRadius: BorderRadius.circular(12.0),
//       ),
//       child: Stack(
//         children: [
//           Row(
//             children: [
//               // Image Container
//               Container(
//                 height: 100,
//                 width: 100,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12.0),
//                   image: const DecorationImage(
//                     image: AssetImage(
//                         'assets/titanic.jpg'), // Replace with your asset
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 12.0),
//               // Text Content
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       "Trailer",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 14.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 8.0),
//                     Text(
//                       "Aladdin, a street boy who falls in love with a princess. With differences in caste and wealth, Aladdin tries to find...",
//                       style: TextStyle(
//                         color: Colors.white.withOpacity(0.8),
//                         fontSize: 10.0,
//                       ),
//                       maxLines: 3,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           // Play Button Overlay
//           Positioned(
//             top: 30.0,
//             left: 35.0,
//             child: Icon(
//               Icons.play_circle_outline_outlined,
//               size: 30.0,
//               color: const Color.fromARGB(91, 255, 255, 255).withOpacity(0.9),
//             ),
//           ),
//           // Download Button
//           Positioned(
//             top: 8.0,
//             right: 8.0,
//             child: Icon(
//               Icons.play_for_work_outlined,
//               color: Colors.white.withOpacity(0.8),
//               size: 24.0,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
