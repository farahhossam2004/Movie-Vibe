import 'package:flutter/material.dart';
import 'package:movie_theater/presentation/pages/signup_page.dart';
import 'package:movie_theater/presentation/pages/welcome.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the home page after a delay
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0B1E), // Background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Your logo or image
            Image.asset(
              'assets/movie.png', // Path to your logo
              width: 180,
              height: 180,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            // Optional: Add a loading indicator
            const CircularProgressIndicator(
              color: Colors.red,
            ),
            const SizedBox(height: 10,),
            const Text(
              '🍫 Movies + snacks = perfect day!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
