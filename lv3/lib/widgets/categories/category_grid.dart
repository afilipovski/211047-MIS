import 'package:flutter/material.dart';
import 'package:new_flutter_project/widgets/categories/category_card.dart';

class CategoriesGrid extends StatefulWidget {
  final List<String> categories;
  const CategoriesGrid({super.key, required this.categories});

  @override
  State<CategoriesGrid> createState() => _CategoriesGridState();
}

class _CategoriesGridState extends State<CategoriesGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
        padding: const EdgeInsets.all(4),
        crossAxisCount: 2,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        semanticChildCount: 250,
        childAspectRatio: 800 / 244,
        shrinkWrap: true,
        children: widget.categories
            .map((category) => CategoryCard(
                  category: category,
                ))
            .toList());
  }
}
