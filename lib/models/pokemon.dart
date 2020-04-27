import './pokemonSprites.dart';
import './pokemonStat.dart';
import './pokemonType.dart';

class Pokemon {
  int id;
  int height;
  int weight;
  String name;
  PokemonSprites sprites;
  List<PokemonStat> stats;
  List<PokemonType> types;

  Pokemon(
      {this.id,
      this.name,
      this.height,
      this.weight,
      this.sprites,
      this.stats,
      this.types});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    // list comrehension to cast type ref: https://github.com/dart-lang/sdk/issues/36836#issuecomment-616373305
    return Pokemon(
      id: json['id'],
      name: json['name'],
      height: json['height'],
      weight: json['weight'],
      sprites: PokemonSprites.fromJson(json['sprites']),
      stats: [for (var stat in json['stats']) PokemonStat.fromJson(stat)],
      types: [for (var type in json['types']) PokemonType.fromJson(type)],
    );
  }
}
