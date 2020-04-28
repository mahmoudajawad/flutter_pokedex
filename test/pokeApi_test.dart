import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart';

import 'package:flutter_pokedex/services/pokeApi.dart';
import 'package:flutter_pokedex/services/data.dart';
import './test_constants.dart' as constants;

class MockDataService extends Mock implements DataService {}

class MockHttpClient extends Mock implements Client {}

void main() {
  final data = MockDataService();
  final httpClient = MockHttpClient();
  PokeApiService pokeApi =
      PokeApiService(dataInstance: data, httpClientInstance: httpClient);

  group('PokeApiService.getPokemonById', () {
    test(
        'Get Pokémon with id \'1\' should call httpClient and retrieve data from PokeAPI',
        () async {
      // Stub return null on data.getString
      when(data.getString('pokemon_id_1')).thenAnswer((_) => null);
      // Stub return constants.pokemonId1Response on httpClient.get
      when(httpClient.get('https://pokeapi.co/api/v2/pokemon/1/'))
          .thenAnswer((_) async => Response(constants.pokemonId1Response, 200));
      // Assert name of the Pokémon returned by call is 'bulbasaur'
      expect((await pokeApi.getPokemonById(1)).name, 'bulbasaur');
      // Assert data.setString was called
      verify(data.setString('pokemon_id_1', constants.pokemonId1Response));
      // Reset Mock implementations for other tests
      reset(data);
      reset(httpClient);
    });

    test(
        'Get Pokémon with id \'1\' second time should call data and retrieve data from storage',
        () async {
      // Stub return constants.pokemonId1Response on data.getString
      when(data.getString('pokemon_id_1'))
          .thenAnswer((_) => constants.pokemonId1Response);
      // Assert name of the Pokémon returned by call is 'bulbasaur'
      expect((await pokeApi.getPokemonById(1)).name, 'bulbasaur');
      // Assert data.setString, httpClient.get were not called
      verifyNever(data.setString('pokemon_id_1', constants.pokemonId1Response));
      verifyNever(httpClient.get('https://pokeapi.co/api/v2/pokemon/1/',
          headers: null));
      // Reset Mock implementations for other tests
      reset(data);
      reset(httpClient);
    });

    test('Throw exception when getting Pokémon with id \'1000\'', () async {
      // Stub return null on data.getString
      when(data.getString('pokemon_id_1000')).thenAnswer((_) => null);
      // Stub return constants.pokemonId1Response on httpClient.get
      when(httpClient.get('https://pokeapi.co/api/v2/pokemon/1000/'))
          .thenAnswer((_) async => Response('Not Found', 400));
      // Assert name of the Pokémon returned by call is 'bulbasaur'
      expect(pokeApi.getPokemonById(1000), throwsException);
      // Assert data.setString was called
      verifyNever(data.setString('pokemon_id_1000', 'Not Found'));
      // Reset Mock implementations for other tests
      reset(data);
      reset(httpClient);
    });
  });
}
