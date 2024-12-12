import 'dart:convert';

import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/categories/category_grid.dart';
import 'random_joke.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> jokeCategories = [];

  @override
  void initState() {
    super.initState();
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
      body: CategoriesGrid(categories: jokeCategories),
    );
  }
}
