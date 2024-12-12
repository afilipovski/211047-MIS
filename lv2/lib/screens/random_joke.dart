import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:new_flutter_project/services/api_service.dart';
import 'dart:convert';

import '../models/joke_model.dart';

class JokeScreen extends StatefulWidget {
  const JokeScreen({super.key});

  @override
  _JokeScreenState createState() => _JokeScreenState();
}

class _JokeScreenState extends State<JokeScreen> {
  bool isLoading = true;
  Joke? joke;

  @override
  void initState() {
    super.initState();
    setJoke();
  }

  Future<void> setJoke() async {
    setState(() {
      isLoading = true;
    });
    final fetchedJoke = await ApiService.fetchRandomJoke();
    setState(() {
      joke = fetchedJoke;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Joke'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      joke?.setup ?? '',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Text(
                      joke?.punchline ?? '',
                      style: TextStyle(fontSize: 18.0, color: Colors.grey[800]),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: setJoke,
                      child: Text('Get Another Joke'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
