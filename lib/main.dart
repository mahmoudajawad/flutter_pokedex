import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:flutter_pokedex/routes.dart';
import 'package:flutter_pokedex/theme/appTheme.dart';
import 'package:flutter_pokedex/services/pokeApi.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  GetIt.I.registerSingleton<PokeApiService>(PokeApiService());
}


void main() {
  runApp(MyApp());
  setupGetIt();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Pokédex',
      theme: appTheme(),
      initialRoute: '/',
      onGenerateRoute: RouteConfiguration.onGenerateRoute,
    );
  }
}
