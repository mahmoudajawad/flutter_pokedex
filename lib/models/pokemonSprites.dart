List<String> spritesList = [
  'frontDefault',
  'backDefault',
  'frontFemale',
  'backFemale',
  'frontShiny',
  'backShiny',
  'frontShinyFemale',
  'backShinyFemale'
];

class PokemonSprites {
  String backDefault;
  String backFemale;
  String backShiny;
  String backShinyFemale;
  String frontDefault;
  String frontFemale;
  String frontShiny;
  String frontShinyFemale;

  PokemonSprites(
      {this.backDefault,
      this.backFemale,
      this.backShiny,
      this.backShinyFemale,
      this.frontDefault,
      this.frontFemale,
      this.frontShiny,
      this.frontShinyFemale});

  factory PokemonSprites.fromJson(Map<String, dynamic> json) {
    return PokemonSprites(
        backDefault: json['back_default'],
        backFemale: json['back_female'],
        backShiny: json['back_shiny'],
        backShinyFemale: json['back_shiny_female'],
        frontDefault: json['front_default'],
        frontFemale: json['front_female'],
        frontShiny: json['front_shiny'],
        frontShinyFemale: json['front_shiny_female']);
  }

  dynamic getProp(String key) => <String, dynamic>{
        'backDefault': backDefault,
        'backFemale': backFemale,
        'backShiny': backShiny,
        'backShinyFemale': backShinyFemale,
        'frontDefault': frontDefault,
        'frontFemale': frontFemale,
        'frontShiny': frontShiny,
        'frontShinyFemale': frontShinyFemale
      }[key];
}
