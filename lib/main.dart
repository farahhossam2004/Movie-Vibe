import 'package:flutter/material.dart';
import 'package:movie_theater/presentation/widgets/splash_screen.dart';
import 'package:movie_theater/provider/user_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie Theater',
      home: SplashScreen(), // Set SplashScreen as the initial screen
    );
  }
}
