import 'package:flutter/material.dart';
import 'package:new_flutter_project/widgets/categories/joke_category_data.dart';

import '../../models/joke_model.dart';
import '../../screens/jokes.dart';

class CategoryCard extends StatelessWidget {
  final String category;
  final List<Joke> favoriteJokes;
  final Function(Joke) onFavoriteToggle;

  const CategoryCard({
    super.key,
    required this.category,
    required this.favoriteJokes,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: InkWell(
          borderRadius: BorderRadius.circular(10),
          splashColor: Colors.red[50],
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => JokesScreen(
                  category: category,
                  favoriteJokes: favoriteJokes,
                  onFavoriteToggle: onFavoriteToggle,
                ),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.all(5.0),
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
                border:
                    Border.all(color: Colors.red.withOpacity(0.8), width: 2),
                borderRadius: BorderRadius.circular(10)),
            child: JokeCategoryData(name: category),
          )),
    );
  }
}
