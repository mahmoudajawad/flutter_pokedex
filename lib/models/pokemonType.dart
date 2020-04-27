class PokemonType {
  int slot;
  int id;
  String name;

  PokemonType({this.slot, this.id, this.name});

  factory PokemonType.fromJson(Map<String, dynamic> json) {
    List<String> urlSplit = json['type']['url'].split('/');
    return PokemonType(
        slot: json['slot'],
        id: int.parse(urlSplit[urlSplit.length - 2]),
        name: json['type']['name']);
  }
}
