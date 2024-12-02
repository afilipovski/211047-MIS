import 'dart:convert';

import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/pokemon/pokemon_grid.dart';

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
    getPokemonFromAPI();
  }

  void getPokemonFromAPI() async {
    ApiService.getJokeCategories().then((response) {
      var data = List.from(json.decode(response.body));
      setState(() {
        jokeCategories = data.map((element) => element as String).toList();
        print(jokeCategories);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent[100],
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu, color: Colors.white, size: 24)),
        title: const Text("Jokes app",
            style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.settings, color: Colors.white, size: 24))
        ],
      ),
      body: CategoriesGrid(categories: jokeCategories),
    );
  }
}
