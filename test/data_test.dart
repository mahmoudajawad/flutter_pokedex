import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_pokedex/services/data.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  final storage = MockSharedPreferences();
  DataService data = DataService(instance: storage);
  group('DataService', () {
    test('Storage should be initialised', () {
      expect(data.inited, true);
    });

    test('Get null value for key \'key\'', () {
      when(storage.getString('key')).thenAnswer((_) => null);

      expect(data.getString('key'), null);
      // Reset Mock implementations for other tests
      reset(storage);
    });

    test('Get \'true\' when setting key \'key\' to \'val\'', () async {
      when(storage.setString('key', 'val')).thenAnswer((_) async => true);

      expect(await data.setString('key', 'val'), true);
      // Reset Mock implementations for other tests
      reset(storage);
    });

    test('Get value \'val\' for key \'key\'', () {
      when(storage.getString('key')).thenAnswer((_) => 'val');

      expect(data.getString('key'), 'val');
      // Reset Mock implementations for other tests
      reset(storage);
    });

    test('Get \'true\' when removing key \'key\'', () async {
      when(storage.remove('key')).thenAnswer((_) async => true);

      expect(await data.remove('key'), true);
      // Reset Mock implementations for other tests
      reset(storage);
    });
  });
}