import 'dart:math';
import 'package:flutter/material.dart';

import 'package:flutter_pokedex/screens/todayPokemon/components/pokemonInfo.dart';
import 'package:flutter_pokedex/services/pokeApi.dart';
import 'package:flutter_pokedex/models/pokemon.dart';
import 'package:flutter_pokedex/utils/enums.dart';
import 'package:flutter_pokedex/utils/logger.dart';

class TodayPokemonPage extends StatefulWidget {
  TodayPokemonPage() : super();

  @override
  _TodayPokemonPageState createState() => _TodayPokemonPageState();
}

class _TodayPokemonPageState extends State<TodayPokemonPage> {
  PokeApiService pokeApi = PokeApiService();
  PokemonOption _pokemonOption;
  Pokemon _pokemon;
  bool _pokemonLoaded = false;

  _TodayPokemonPageState() {
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
          _pokemonOption = PokemonOption.TODAY;
          _pokemon = value;
          _pokemonLoaded = true;
        });
      });
    });
  }

  void _getRandomPokemon() async {
    Future.delayed(Duration(milliseconds: 0)).then((value) => _resetPokemon());
    Future.delayed(Duration(milliseconds: 25)).then((value) {
      // SO ref: https://stackoverflow.com/a/59274189/2393762
      Random random = new Random();
      int randomNumber = random.nextInt(365);
      pokeApi.getPokemonById(randomNumber).then((value) {
        setState(() {
          _pokemonOption = PokemonOption.RANDOM;
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
            (_pokemonOption == PokemonOption.TODAY)
                ? Text(
                    'The Pokémon of today is:',
                  )
                : Text(
                    'The Random Pokémon is:',
                  ),
            !_pokemonLoaded
                ? Text('Loading...')
                : PokemonInfo(pokemon: _pokemon),
          ],
        ),
      ),
      floatingActionButton: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 60),
            child: FloatingActionButton(
              backgroundColor: (_pokemonOption == PokemonOption.TODAY)
                  ? Colors.orange
                  : Colors.deepOrange,
              onPressed: _getRandomPokemon,
              tooltip: 'Random',
              child: Icon(Icons.refresh),
            ),
          ),
          FloatingActionButton(
            backgroundColor: (_pokemonOption == PokemonOption.TODAY)
                ? Colors.deepOrange
                : Colors.orange,
            onPressed: _getTodayPokemon,
            tooltip: 'Pokemon of Today',
            child: Icon(Icons.calendar_today),
          ),
        ],
      ),
    );
  }
}
