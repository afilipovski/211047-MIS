import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/joke_model.dart';

class ApiService {
  static Future<http.Response> getJokeCategories() async {
    var response = await http
        .get(Uri.parse("https://official-joke-api.appspot.com/types"));
    print("Response: ${response.body}");
    return response;
  }

  static Future<List<Joke>> fetchJokes(String category) async {
    final url =
        Uri.parse('https://official-joke-api.appspot.com/jokes/$category/ten');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jokeList = json.decode(response.body);
      return jokeList.map((json) => Joke.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load jokes');
    }
  }

  static Future<Joke> fetchRandomJoke() async {
    const String apiUrl = 'https://official-joke-api.appspot.com/random_joke';
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Joke.fromJson(data);
      } else {
        return Joke(
          setup: 'Failed to fetch joke',
          punchline: 'Please try again later.',
        );
      }
    } catch (error) {
      return Joke(
        setup: 'An error occurred',
        punchline: 'Check your internet connection.',
      );
    }
  }
}
