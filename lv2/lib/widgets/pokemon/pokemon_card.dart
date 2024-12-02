import 'package:flutter/material.dart';
import 'package:new_flutter_project/models/poke_model.dart';
import 'package:new_flutter_project/widgets/pokemon/pokemon_card_data.dart';

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
          onTap: () => {
                // Navigator.pushNamed(context, '/details',
                //     arguments: Pokemon(id: id, name: name, image: image))
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
