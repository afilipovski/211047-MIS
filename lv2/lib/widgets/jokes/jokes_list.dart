import 'package:flutter/widgets.dart';

import '../../models/joke_model.dart';
import 'joke_card.dart';

class JokesList extends StatelessWidget {
  final List<Joke> jokes;

  const JokesList({Key? key, required this.jokes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: jokes.length,
      itemBuilder: (context, index) {
        final joke = jokes[index];
        return JokeCard(joke: joke);
      },
    );
  }
}
