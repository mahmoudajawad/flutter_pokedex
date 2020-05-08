import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:flutter_pokedex/utils/stringUtils.dart';
import 'package:flutter_pokedex/services/pokeApi.dart';
import 'package:flutter_pokedex/models/pokemon.dart';
import 'package:flutter_pokedex/utils/logger.dart';

class PokemonStatsPage extends StatefulWidget {
  PokemonStatsPage({Key key, @required this.pokemonId}) : super(key: key);

  final int pokemonId;

  @override
  _PokemonStatsPageState createState() => _PokemonStatsPageState();
}

class _PokemonStatsPageState extends State<PokemonStatsPage> {
  Pokemon _pokemon;
  bool _pokemonLoaded = false;

  @override
  void initState() {
    super.initState();
    GetIt.I<PokeApiService>().getPokemonById(widget.pokemonId).then((value) {
      log(LogType.DEBUG, 'Setting Pokemon');
      setState(() {
        _pokemon = value;
        _pokemonLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokémon Stats'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '[${_pokemon.id}] ${capitalise(_pokemon.name)}',
              style: Theme.of(context).textTheme.headline4,
            ),
            !_pokemonLoaded
                ? Text('Loading...')
                // DataTable ref: https://api.flutter.dev/flutter/material/DataTable-class.html
                : DataTable(
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text(
                          'ID',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Name',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Effort',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Base Stat',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                    rows: <DataRow>[
                      for (var stat in _pokemon.stats)
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text(stat.id.toString())),
                          DataCell(Text(capitalise(stat.name))),
                          DataCell(Text(stat.effort.toString())),
                          DataCell(Text(stat.baseStat.toString())),
                        ],
                      )],
                  ),
          ],
        ),
      ),
    );
  }
}
