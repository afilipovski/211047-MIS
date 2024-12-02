import 'package:flutter/material.dart';
import 'package:new_flutter_project/models/ability_model.dart';

class DetailData extends StatelessWidget {
  final int id;
  final Poke pokemon;
  const DetailData({super.key, required this.id, required this.pokemon});


  @override
  Widget build(BuildContext context) {
    final abilities = pokemon.abilities;
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.redAccent[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: abilities.length,
          itemBuilder: (context, index) {
        return ListTile(
          title: Text(abilities[index].ability.name,
              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500)),
          tileColor: Colors.redAccent[50],
        );
      }),
    );
  }
}
