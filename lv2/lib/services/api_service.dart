import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<http.Response> getJokeCategories() async {
    var response = await http
        .get(Uri.parse("https://official-joke-api.appspot.com/types"));
    print("Response: ${response.body}");
    return response;
  }

  static Future<dynamic> getAbilitiesForPokemon(String id) async {
    final response =
        await http.get(Uri.parse("https://pokeapi.co/api/v2/pokemon/$id"));
    if (response.statusCode == 200) {
      print("Success: ${response.body}");
      var data = jsonDecode(response.body);
      print("data $data");
      return data;
    } else {
      throw Exception("Failed to load data!");
    }
  }
}
