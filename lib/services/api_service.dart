
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';

class ApiService {
  static const String baseUrl = 'http://192.168.1.5:5000/api';

  // Fetch all movies
  static Future<List<Movie>> getMovies() async {
    final response = await http.get(Uri.parse('$baseUrl/movies'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  // Search movies by title
  static Future<List<Movie>> searchMovies(String query) async {
    final response =
        await http.get(Uri.parse('$baseUrl/movies/search?query=$query'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load search results');
    }
  }

  // Signup
  static Future<Map<String, dynamic>> signUp(
      String username, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
          {'username': username, 'email': email, 'password': password}),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body); // Return the response data
    } else {
      throw Exception('Failed to sign up');
    }
  }

  // Login
  static Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // Return the response data
    } else {
      throw Exception('Failed to login');
    }
  }
}