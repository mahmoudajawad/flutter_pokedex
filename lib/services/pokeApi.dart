import 'package:http/http.dart';
import 'dart:convert';

import 'package:flutter_pokedex/services/data.dart';
import 'package:flutter_pokedex/models/pokemon.dart';
import 'package:flutter_pokedex/utils/logger.dart';

class PokeApiService {
  DataService data;
  Client httpClient;

  PokeApiService({DataService dataInstance, Client httpClientInstance}) {
    log(LogType.DEBUG, 'Initing PokeApiService');
    data =  (dataInstance == null) ? DataService() : dataInstance;
    httpClient =  (httpClientInstance == null) ? Client() : httpClientInstance;
  }

  Future<Pokemon> getPokemonById(int id) async {
    log(LogType.DEBUG, 'Attemting to load Pokémon by number: $id');

    log(LogType.DEBUG, 'Checking data for cached Pokémon info');
    try {
      final pokemonString = data.getString('pokemon_id_$id');
      if (pokemonString != null) {
        log(LogType.DEBUG, 'Found Pokémon in storage. Loading it..');
        return Pokemon.fromJson(json.decode(pokemonString));
      }
    } catch (e) {
      log(LogType.DEBUG, 'No Pokémon info in storage');
      log(LogType.DEBUG, 'Exception raised: $e');
    }

    final response = await httpClient.get('https://pokeapi.co/api/v2/pokemon/$id/');

    if (response.statusCode == 200) {
      log(LogType.DEBUG, 'Saving loaded Pokémon info to storage');
      await data.setString('pokemon_id_$id', response.body);
      try {
        return Pokemon.fromJson(json.decode(response.body));
      } catch (e) {
        log(LogType.ERR, 'Error occured when attempted to process response. Exception:');
        log(LogType.ERR, e);
      }
    }

    log(LogType.ERR, 'Received non-OK response from PokeAPI. Status, response:');
    log(LogType.ERR, response.statusCode);
    log(LogType.ERR, response.body);
    
    throw Exception('Failed to get Pokemon');
  }
}
