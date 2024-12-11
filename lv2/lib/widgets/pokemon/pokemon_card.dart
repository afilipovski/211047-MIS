import 'package:flutter/material.dart';
import 'package:new_flutter_project/widgets/pokemon/pokemon_card_data.dart';

import '../../screens/jokes.dart';

class CategoryCard extends StatelessWidget {
  final String category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: InkWell(
          borderRadius: BorderRadius.circular(10),
          splashColor: Colors.red[50],
          onTap: () {
            print("fjenfnje");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => JokesScreen(category: category),
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
