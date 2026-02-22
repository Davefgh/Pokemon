class Pokemon {
  final int id;
  final String name;
  final Sprites sprites;
  final int height;
  final int weight;

  Pokemon({
    required this.id,
    required this.name,
    required this.sprites,
    required this.height,
    required this.weight,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      sprites: Sprites.fromJson(json['sprites'] ?? {}),
      height: json['height'] ?? 0,
      weight: json['weight'] ?? 0,
    );
  }
}

class Sprites {
  final String frontDefault;

  Sprites({
    required this.frontDefault,
  });

  factory Sprites.fromJson(Map<String, dynamic> json) {
    return Sprites(
      frontDefault: json['front_default'] ?? '',
    );
  }
}
