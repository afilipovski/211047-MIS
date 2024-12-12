import 'package:flutter/material.dart';
import 'package:new_flutter_project/widgets/error.dart';
import 'package:new_flutter_project/widgets/jokes/jokes_list.dart';

import '../../models/joke_model.dart';

class JokesBody extends StatelessWidget {
  final Future<List<Joke>> jokesFuture;

  const JokesBody({Key? key, required this.jokesFuture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Joke>>(
      future: jokesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return JokeErrorWidget(message: 'Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No jokes found.'));
        } else {
          return JokesList(jokes: snapshot.data!);
        }
      },
    );
  }
}
