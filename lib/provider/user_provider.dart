import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_theater/models/movie.dart';
import 'package:movie_theater/models/user.dart';
import 'dart:convert';

class UserProvider with ChangeNotifier {
  User? _user;
  List<Movie> _savedMovies = []; // List of saved movies

  User? get user => _user;
  List<Movie> get savedMovies => _savedMovies;

  void setUser(User user) {
    _user = user;
    notifyListeners();
    fetchSavedMovies(); // Fetch saved movies when user is set
  }

  void clearUser() {
    _user = null;
    _savedMovies = []; // Clear saved movies when user logs out
    notifyListeners();
  }

  // Fetch saved movies from the backend
  Future<void> fetchSavedMovies() async {
    if (_user == null) return;

    try {
      final response = await http.get(
        Uri.parse('http://192.168.1.10:5000/api/auth/saved-movies/${_user!.id}'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body)['savedMovies'];
        _savedMovies = data.map((movie) => Movie.fromJson(movie)).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load saved movies');
      }
    } catch (e) {
      print('Error fetching saved movies: $e');
    }
  }

  // Add a movie to the saved list
  Future<void> addSavedMovie(Movie movie) async {
    if (_user == null) return;

    if (!_savedMovies.contains(movie)) {
      _savedMovies.add(movie);
      notifyListeners();

      // Save to backend
      try {
        final response = await http.post(
          Uri.parse('http://192.168.1.10:5000/api/auth/save-movie'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'userId': _user!.id, 'movieId': movie.id}),
        );

        if (response.statusCode != 200) {
          // Rollback if the API call fails
          _savedMovies.remove(movie);
          notifyListeners();
          throw Exception('Failed to save movie');
        }
      } catch (e) {
        print('Error saving movie: $e');
      }
    }
  }

  // Remove a movie from the saved list
  Future<void> removeSavedMovie(Movie movie) async {
    if (_user == null) return;

    if (_savedMovies.contains(movie)) {
      _savedMovies.remove(movie);
      notifyListeners();

      // Remove from backend
      try {
        final response = await http.post(
          Uri.parse('http://192.168.1.10:5000/api/auth/remove-movie'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'userId': _user!.id, 'movieId': movie.id}),
        );

        if (response.statusCode != 200) {
          // Rollback if the API call fails
          _savedMovies.add(movie);
          notifyListeners();
          throw Exception('Failed to remove movie');
        }
      } catch (e) {
        print('Error removing movie: $e');
      }
    }
  }

  // Check if a movie is saved
  bool isMovieSaved(Movie movie) {
    return _savedMovies.contains(movie);
  }
}