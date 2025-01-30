import 'package:flutter/material.dart';
import 'package:movie_theater/presentation/widgets/movie_container.dart';

class DownloadsPage extends StatelessWidget {
  const DownloadsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Column(
        children: [
          const Center(
              child: Text(
            "Download",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),
          )),
          DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  const TabBar(
                    labelStyle:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                    labelColor: Colors.red,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.red,
                    dividerHeight: 0.2,
                    indicatorWeight: 1,
                    tabs: [
                      Tab(text: 'Downloaded'),
                      Tab(text: 'Downloading'),
                    ],
                  ),
                  SizedBox(
                    height: 140, // Set a height for the TabBarView
                    child: TabBarView(
                      children: [
                        // first Tab Content
                        MovieContainer(
                          imageUrl: 'https://th.bing.com/th/id/R.d95871cc5d2d407847f0216e390bb7aa?rik=22SxS5VOZ1pWVw&pid=ImgRaw&r=0',
                          title: 'Avatar',
                          description: 'Action, Adevntures',
                          size: '1.2GB',
                          duration: '2:05:32',
                        ),
                        // second tab
                        const Center(
                          child: Text(
                            'downloading....',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        // About Tab Content
                      ],
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}

