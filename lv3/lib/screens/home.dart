import 'dart:convert';

import 'package:flutter/material.dart';
import '../models/joke_model.dart';
import '../services/api_service.dart';
import '../widgets/categories/category_grid.dart';
import 'random_joke.dart';
import 'favorites.dart';
import 'package:new_flutter_project/notifications/notification_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> jokeCategories = [];
  final List<Joke> favoriteJokes = [];
  final NotificationService _notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    ApiService.getJokeCategories().then((response) => {
          if (response.statusCode == 200)
            {
              setState(() {
                jokeCategories = json.decode(response.body).cast<String>();
              })
            }
        });
    _notificationService.initialize();
    _notificationService.scheduleDailyNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent[100],
        title: const Text("Jokes app",
            style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      FavoritesScreen(favoriteJokes: favoriteJokes),
                ),
              );
            },
          ),
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => JokeScreen()),
                );
              },
              icon: const Icon(Icons.emoji_emotions,
                  color: Colors.white, size: 24))
        ],
      ),
      body: CategoriesGrid(
        categories: jokeCategories,
        favoriteJokes: favoriteJokes,
        onFavoriteToggle: (joke) {
          setState(() {
            if (favoriteJokes.contains(joke)) {
              favoriteJokes.remove(joke);
            } else {
              favoriteJokes.add(joke);
            }
          });
        },
      ),
    );
  }
}
