import 'package:flutter/material.dart';
import 'package:movie_theater/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:movie_theater/presentation/pages/login_page.dart'; // Import your LoginPage

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    return Scaffold(
      backgroundColor: const Color(0xFF0D0B1E), // Background color
      appBar: AppBar(
        
        title: const Center(
          child:  Text(
            'Your Profile',
            style: TextStyle(color: Colors.red),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 32, 28, 59),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white), // Back button color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Welcome Message
            const Text(
              '🍿 Grab some popcorn and enjoy!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Your cinematic journey continues! 🎞️',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 20),
            // User Info Container
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: const Color(0xFF1C1A2E), // Container background color
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name with Icon
                  Row(
                    children: [
                      const Icon(
                        Icons.person_outline, // Icon for name
                        color: Colors.red,
                        size: 20,
                      ),
                      const SizedBox(width: 8), // Space between icon and text
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Name',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            user?.username ?? 'No username',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16), // Space between name and email
                  // Email with Icon
                  Row(
                    children: [
                      const Icon(
                        Icons.email_outlined, // Icon for email
                        color: Colors.red,
                        size: 20,
                      ),
                      const SizedBox(width: 8), // Space between icon and text
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Email',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            user?.email ?? 'No email',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(), // Pushes the button to the bottom
            // Logout Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 10, // Space between text and button
                children: [
                  // Creative Sentence
                  const Text(
                    'Feeling cinematic? Log out and come back later! 🎬',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.center, // Center-align the text
                  ),
                  // Smaller Logout Button with Icon
                  ElevatedButton(
                    onPressed: () {
                      // Logout logic
                      userProvider.clearUser(); // Clear user data
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 224, 221, 221), // Button color
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.logout, // Logout icon
                          color: Colors.red,
                          size: 16,
                        ),
                        SizedBox(width: 6), // Space between icon and text
                        Text(
                          'Logout',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
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
    );
  }
}