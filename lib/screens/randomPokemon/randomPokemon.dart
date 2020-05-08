import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:flutter_pokedex/components/pokemonInfo.dart';
import 'package:flutter_pokedex/services/pokeApi.dart';
import 'package:flutter_pokedex/models/pokemon.dart';
import 'package:flutter_pokedex/utils/logger.dart';


class RandomPokemonPage extends StatefulWidget {
  RandomPokemonPage({Key key}) : super(key: key);

  @override
  _RandomPokemonPageState createState() => _RandomPokemonPageState();
}

class _RandomPokemonPageState extends State<RandomPokemonPage> {
  Pokemon _pokemon;
  bool _pokemonLoaded = false;

  @override
  void initState() {
    super.initState();
    _getRandomPokemon();
  }

  void _resetPokemon() {
    log(LogType.DEBUG, 'Resetting Pokemon');
    setState(() {
      _pokemonLoaded = false;
      _pokemon = null;
    });
  }

  void _getRandomPokemon() async {
    Future.delayed(Duration(milliseconds: 0)).then((value) => _resetPokemon());
    Future.delayed(Duration(milliseconds: 25)).then((value) {
      // SO ref: https://stackoverflow.com/a/59274189/2393762
      Random random = new Random();
      int randomNumber = random.nextInt(365);
      GetIt.I<PokeApiService>().getPokemonById(randomNumber).then((value) {
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
        title: Text('Random Pokémon'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
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
          FloatingActionButton(
            heroTag: 'randomFAB',
            backgroundColor: Colors.orange,
            onPressed: _getRandomPokemon,
            tooltip: 'Random',
            child: Icon(Icons.refresh),
          )
        ],
      ),
    );
  }
}
