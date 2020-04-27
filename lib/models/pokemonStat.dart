class PokemonStat {
  int baseStat;
  int effort;
  int id;
  String name;

  PokemonStat({this.baseStat, this.effort, this.id, this.name});

  factory PokemonStat.fromJson(Map<String, dynamic> json) {
    List<String> urlSplit = json['stat']['url'].split('/');
    return PokemonStat(
        baseStat: json['base_stat'],
        effort: json['effort'],
        id: int.parse(urlSplit[urlSplit.length - 2]),
        name: json['stat']['name']);
  }
}
