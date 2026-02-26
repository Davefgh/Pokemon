import 'dart:convert';
import 'package:http/http.dart' as http;
import 'pokemon.dart';

class PokemonService {
  static const String baseUrl = 'https://pokeapi.co/api/v2/pokemon/';

  Future<Pokemon> fetchPokemon(String name) async {
    final response = await http.get(Uri.parse('$baseUrl$name'));

    if (response.statusCode == 200) {
      return Pokemon.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load pokemon: $name');
    }
  }
}
