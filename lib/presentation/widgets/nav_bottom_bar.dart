import 'package:flutter/material.dart';

class NavBottomBar extends StatefulWidget {
  final ValueChanged<int> onTap; // Callback for handling index change
  final int currentIndex; // Current selected index

  const NavBottomBar({
    super.key,
    required this.onTap,
    required this.currentIndex,
  });

  @override
  State<NavBottomBar> createState() => _NavBottomBarState();
}

class _NavBottomBarState extends State<NavBottomBar> {
  @override
  Widget build(BuildContext context) {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        backgroundColor: const Color.fromARGB(255, 32, 28, 59),
        indicatorColor: Colors.red,
        indicatorShape: const CircleBorder(
          eccentricity: 0.1
        ),
        labelTextStyle: MaterialStateProperty.all(
          const TextStyle(
            fontSize: 8, // Smaller font size for labels
            color: Colors.white,
            fontWeight: FontWeight.bold // Label color
          ),
        ),
      ),
      child: NavigationBar(
        height: 55,
        onDestinationSelected: widget.onTap,
        selectedIndex: widget.currentIndex,
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(Icons.home, size: 18.0, color: Colors.white),
            icon: Icon(Icons.home_filled, size: 18.0, color: Colors.white),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.search, size: 18.0, color: Colors.white),
            icon: Icon(Icons.search, size: 18.0, color: Colors.white),
            label: 'Search',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.bookmark, size: 18.0, color: Colors.white),
            icon: Icon(Icons.bookmark_border, size: 18.0, color: Colors.white),
            label: 'Saved',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.download_for_offline_sharp, size: 18.0, color: Colors.white),
            icon: Icon(Icons.download_for_offline_outlined, size: 16.0, color: Colors.white),
            label: 'Downloads',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person, size: 18.0, color: Colors.white),
            icon: Icon(Icons.person_outline, size: 18.0, color: Colors.white),
            label: 'Me',
          ),
        ],
      ),
    );
  }
}

