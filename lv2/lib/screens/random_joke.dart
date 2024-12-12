import 'package:flutter/material.dart';
import 'package:new_flutter_project/services/api_service.dart';
import 'package:new_flutter_project/widgets/jokes/random_joke_card.dart';
import '../models/joke_model.dart';
import '../widgets/jokes/loading_indicator.dart';

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
            ? const LoadingIndicator()
            : RandomJokeCard(joke: joke!, onGetNewJoke: setJoke),
      ),
    );
  }
}
