import 'package:flutter/material.dart';
import 'package:new_flutter_project/widgets/error.dart';

import '../../models/joke_model.dart';

class JokesBody extends StatefulWidget {
  final Future<List<Joke>> jokesFuture;
  final List<Joke> favoriteJokes;
  final Function(Joke) onFavoriteToggle;

  const JokesBody({
    super.key,
    required this.jokesFuture,
    required this.favoriteJokes,
    required this.onFavoriteToggle,
  });

  @override
  _JokesBodyState createState() => _JokesBodyState();
}

class _JokesBodyState extends State<JokesBody> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Joke>>(
      future: widget.jokesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return JokeErrorWidget(message: 'Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No jokes found.'));
        } else {
          final jokes = snapshot.data!;
          return ListView.builder(
            itemCount: jokes.length,
            itemBuilder: (context, index) {
              final joke = jokes[index];
              final isFavorite = widget.favoriteJokes.contains(joke);
              return ListTile(
                title: Text(joke.setup),
                subtitle: Text(joke.punchline),
                trailing: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : null,
                  ),
                  onPressed: () {
                    widget.onFavoriteToggle(joke);
                    setState(() {});
                  },
                ),
              );
            },
          );
        }
      },
    );
  }
}
