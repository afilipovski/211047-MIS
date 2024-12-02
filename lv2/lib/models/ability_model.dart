import 'dart:convert';

Poke pokeFromJson(String str) => Poke.fromJson(json.decode(str));


class Poke {
  final List<Ability> abilities;
  final int baseExperience;
  final List<Species> forms;
  final int id;
  final String name;
  final int order;
  final Species species;

  Poke({
    this.abilities = const [],
    this.baseExperience = 0,
    this.forms = const [],
    this.id = 0,
    this.name = '',
    this.order = 0,
    this.species = const Species(),
  });

  factory Poke.fromJson(Map<String, dynamic> json) => Poke(
    abilities: List<Ability>.from(json["abilities"].map((x) => Ability.fromJson(x))) ?? [],
    baseExperience: json['baseExperience'] ?? 0,
    forms: List<Species>.from(json["forms"].map((x) => Species.fromJson(x))) ?? [],
    id: json["id"] ?? 1,
    name: json["name"] ?? '',
    order: json["order"] ?? 0,
    species: Species.fromJson(json["species"]),
  );
}

class Ability {
  final Species ability;
  final bool isHidden;
  final int slot;

 Ability({
    this.ability = const Species(),
    this.isHidden = false,
    this.slot = 0,
  });

  factory Ability.fromJson(Map<String, dynamic> json) => Ability(
    ability: Species.fromJson(json["ability"]),
    isHidden: json["is_hidden"] ?? false,
    slot: json["slot"] ?? 1,
  );

}

class Species {
  final String name;
  final String url;

  const Species({
    this.name = '',
    this.url = '',
  });

  factory Species.fromJson(Map<String, dynamic> json) => Species(
    name: json["name"] ?? '',
    url: json["url"] ?? '',
  );

}