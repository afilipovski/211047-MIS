import 'package:flutter/material.dart';

class DetailImage extends StatelessWidget {
  final String image;
  const DetailImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        shape: BoxShape.circle, color: Colors.redAccent[100]?.withOpacity(0.5),
      ),
      child: Image.network(image, fit: BoxFit.cover, alignment: Alignment.center),
    );
  }
}
