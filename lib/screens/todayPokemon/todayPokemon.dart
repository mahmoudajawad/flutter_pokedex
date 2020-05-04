import 'dart:math';
import 'package:flutter/material.dart';

import 'package:flutter_pokedex/registry.dart';
import 'package:flutter_pokedex/components/pokemonInfo.dart';
import 'package:flutter_pokedex/services/pokeApi.dart';
import 'package:flutter_pokedex/models/pokemon.dart';
import 'package:flutter_pokedex/utils/enums.dart';
import 'package:flutter_pokedex/utils/logger.dart';

class TodayPokemonPage extends StatefulWidget {
  TodayPokemonPage({Key key, this.registry}) : super(key: key);

  final Registry registry;

  @override
  _TodayPokemonPageState createState() => _TodayPokemonPageState();
}

class _TodayPokemonPageState extends State<TodayPokemonPage> {
  PokeApiService pokeApi;
  Pokemon _pokemon;
  bool _pokemonLoaded = false;

  @override
  void initState() {
    super.initState();
    pokeApi = widget.registry.getService('pokeApi');
    _getTodayPokemon();
  }

  void _resetPokemon() {
    log(LogType.DEBUG, 'Resetting Pokemon');
    setState(() {
      _pokemonLoaded = false;
      _pokemon = null;
    });
  }

  void _getTodayPokemon() async {
    Future.delayed(Duration(milliseconds: 0)).then((_) => _resetPokemon());
    Future.delayed(Duration(milliseconds: 25)).then((_) {
      // SO ref: https://stackoverflow.com/a/59693145/2393762
      final date = DateTime.now();
      final dayOfYear = date.difference(DateTime(date.year, 1, 1)).inDays + 1;

      pokeApi.getPokemonById(dayOfYear).then((value) {
        log(LogType.DEBUG, 'Setting Pokemon');
        setState(() {
          _pokemon = value;
          _pokemonLoaded = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokémon of the Day'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'The Pokémon of today is:',
            ),
            !_pokemonLoaded
                ? Text('Loading...')
                : PokemonInfo(pokemon: _pokemon),
          ],
        ),
      ),
    );
  }
}
