import 'package:dio/dio.dart';
import '../config/api.dart';
import 'pokemon.dart';

class PokemonService {
  final Dio _dio = Dio();

  Future<Pokemon> fetchPokemon(String name) async {
    try {
      final response = await _dio.get('${ApiEndpoints.baseUrl}$name');

      if (response.statusCode == 200) {
        return Pokemon.fromJson(response.data);
      } else {
        throw Exception('Failed to load pokemon: $name');
      }
    } catch (e) {
      throw Exception('Error fetching pokemon: $e');
    }
  }
}
