import 'package:flutter/material.dart';
import 'package:new_flutter_project/services/api_service.dart';
import 'package:new_flutter_project/widgets/jokes/random_joke_card.dart';
import '../models/joke_model.dart';
import '../notifications/notification_service.dart';
import '../widgets/jokes/loading_indicator.dart';

class JokeScreen extends StatefulWidget {
  const JokeScreen({super.key});

  @override
  _JokeScreenState createState() => _JokeScreenState();
}

class _JokeScreenState extends State<JokeScreen> {
  bool isLoading = true;
  Joke? joke;
  final NotificationService _notificationService = NotificationService();


  @override
  void initState() {
    super.initState();
    setJoke();
    _sendStartupNotification();
  }

  void _sendStartupNotification() {
    _notificationService.showNotification(
      id: 0,
      title: 'Joke of the Day',
      body: 'Check out the joke of the day!',
    );
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
