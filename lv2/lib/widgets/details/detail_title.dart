import 'package:flutter/material.dart';

class DetailTitle extends StatelessWidget {
  final int id;
  final String name;

  const DetailTitle({super.key, required this.id, required this.name});

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: Colors.white,
        label: Text(name, style: TextStyle(
          fontSize: 24, color: Colors.red[900]
        ),),
      avatar: CircleAvatar(backgroundColor: Colors.red[50],
          child: Text(id.toString())),
    );
  }
}
