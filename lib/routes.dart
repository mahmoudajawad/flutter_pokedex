import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pokedex/components/appContainer.dart';

import 'package:flutter_pokedex/screens/welcome/welcome.dart';

import 'package:flutter_pokedex/registry.dart';
import 'package:flutter_pokedex/services/pokeApi.dart';

final registry = Registry.fromMap({
  'pokeApi': PokeApiService()
});

// Dynamic Routing Ref: https://medium.com/flutter/flutter-web-navigating-urls-using-named-routes-307e1b1e2050

class Path {
  const Path(this.pattern, this.builder);

  final String pattern;
  final Widget Function(BuildContext, Map<String, String>) builder;
}

class RouteConfiguration {
  static List<Path> paths = [
    Path(r'^/$', (context, matches) => WelcomePage(registry: registry,)),
    Path(r'^/today$', (context, matches) => AppContainer(selectedIndex: 0, registry: registry,)),
    Path(r'^/random$', (context, matches) => AppContainer(selectedIndex: 1, registry: registry,)),
  ];

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    for (Path path in paths) {
      final regExpPattern = RegExp(path.pattern);
      if (regExpPattern.hasMatch(settings.name)) {
        final match = regExpPattern.firstMatch(settings.name);
        Map<String, String> groupNameToMatch = {};
        for (String groupName in match.groupNames) {
          groupNameToMatch[groupName] = match.namedGroup(groupName);
        }
        return MaterialPageRoute<void>(
          builder: (context) => path.builder(context, groupNameToMatch),
          settings: settings,
        );
      }
    }

    return null;
  }
}