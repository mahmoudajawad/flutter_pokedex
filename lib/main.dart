import 'package:flutter/material.dart';

import 'package:flutter_pokedex/routes.dart';
import 'package:flutter_pokedex/theme/appTheme.dart';

void main() {
  runApp(MyApp());
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
