import 'package:flutter/material.dart';

import 'package:flutter_pokedex/utils/stringUtils.dart';
import 'package:flutter_pokedex/models/pokemon.dart';
import 'package:flutter_pokedex/screens/todayPokemon/components/pokemonCarousel.dart';

class PokemonInfo extends StatefulWidget {
  PokemonInfo({Key key, this.pokemon, this.title}) : super(key: key);

  final Pokemon pokemon;
  final String title;

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
        PokemonCarousel(
          pokemon: widget.pokemon,
        ),
        // Text('Pokémon front:'),
        // Image.network(widget.pokemon.sprites.frontDefault),
        // Text('Pokémon front (female):'),
        // (widget.pokemon.sprites.frontFemale != null)
        //     ? Image.network(widget.pokemon.sprites.frontFemale)
        //     : Text('N/A'),
        // Text('Pokémon back:'),
        // Image.network(widget.pokemon.sprites.backDefault),
        // Text('Pokémon back (female):'),
        // (widget.pokemon.sprites.backFemale != null)
        //     ? Image.network(widget.pokemon.sprites.backFemale)
        //     : Text('N/A'),
        // Text('Pokémon shiny front:'),
        // (widget.pokemon.sprites.frontShiny != null)
        //     ? Image.network(widget.pokemon.sprites.frontShiny)
        //     : Text('N/A'),
        // Text('Pokémon shiny front (female):'),
        // (widget.pokemon.sprites.frontShinyFemale != null)
        //     ? Image.network(widget.pokemon.sprites.frontShinyFemale)
        //     : Text('N/A'),
        // Text('Pokémon shiny back:'),
        // (widget.pokemon.sprites.backShiny != null)
        //     ? Image.network(widget.pokemon.sprites.backShiny)
        //     : Text('N/A'),
        // Text('Pokémon shiny back (female):'),
        // (widget.pokemon.sprites.backShinyFemale != null)
        //     ? Image.network(widget.pokemon.sprites.backShinyFemale)
        //     : Text('N/A'),
      ],
    );
  }
}
