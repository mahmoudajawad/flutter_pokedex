import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:flutter_pokedex/routes.dart';
import 'package:flutter_pokedex/theme/appTheme.dart';
import 'package:flutter_pokedex/services/pokeApi.dart';

void setupGetIt() {
  GetIt.I.registerSingleton<PokeApiService>(PokeApiService());
}

void main() {
  final app = App();
  runApp(app);
  setupGetIt();
}

class AppState extends ChangeNotifier {

}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: appKey,
      title: 'Flutter Pokédex',
      theme: appTheme(),
      initialRoute: '/',
      onGenerateRoute: RouteConfiguration.onGenerateRoute,
    );
  }
}
