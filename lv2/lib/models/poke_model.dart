class Pokemon {
  int id;
  String name;
  String image;

  Pokemon({required this.id, required this.name, required this.image});

  Pokemon.fromJson(Map<String, dynamic> data)
      : id = data['id'],
        name = data['name'],
        image = data['img'];

  Map<String, dynamic> toJson() => {'id' : id, 'name' : name, 'img' : image};
}