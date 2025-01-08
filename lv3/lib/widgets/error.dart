import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class JokeErrorWidget extends StatelessWidget {
  final String message;

  const JokeErrorWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: const TextStyle(color: Colors.red),
      ),
    );
  }
}