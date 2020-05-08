import 'package:flutter/material.dart';
import 'package:flutter_pokedex/components/appButton.dart';

import 'package:flutter_pokedex/utils/stringUtils.dart';
import 'package:flutter_pokedex/models/pokemon.dart';
import 'package:flutter_pokedex/components/pokemonCarousel.dart';

class PokemonInfo extends StatefulWidget {
  PokemonInfo({Key key, @required this.pokemon}) : super(key: key);

  final Pokemon pokemon;

  @override
  _PokemonInfoState createState() => _PokemonInfoState();
}

class _PokemonInfoState extends State<PokemonInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          '[${widget.pokemon.id}] ${capitalise(widget.pokemon.name)}',
          style: Theme.of(context).textTheme.headline4,
        ),
        PokemonCarousel(pokemon: widget.pokemon,),
        AppButton(text: 'Pokémon Stats', icon: Icon(Icons.multiline_chart), route: '/stats/${widget.pokemon.id}', removeHistory: false)
      ],
    );
  }
}
