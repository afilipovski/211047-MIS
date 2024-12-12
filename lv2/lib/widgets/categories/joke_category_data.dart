import 'package:flutter/material.dart';

class JokeCategoryData extends StatelessWidget {
  final String name;

  const JokeCategoryData({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          name,
          style: const TextStyle(
              color: Colors.black54, fontSize: 20, fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}
