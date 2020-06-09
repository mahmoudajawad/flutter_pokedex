import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pokedex/components/appContainer.dart';
import 'package:flutter_pokedex/screens/pokemonStats/pokemonStats.dart';
import 'package:flutter_pokedex/screens/todayPokemon/todayPokemon.dart';

import 'package:flutter_pokedex/screens/welcome/welcome.dart';

final GlobalKey<NavigatorState> appKey = new GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> containerKey = new GlobalKey<NavigatorState>();

class NavigatorPage {
  dynamic page;

  NavigatorPage({@required this.page});
}

List<NavigatorPage> pages = [NavigatorPage(page: TodayPokemonPage())];

// Dynamic Routing Ref: https://medium.com/flutter/flutter-web-navigating-urls-using-named-routes-307e1b1e2050

class Path {
  const Path(this.pattern, this.builder);

  final String pattern;
  final Widget Function(BuildContext, Map<String, String>) builder;
}

class RouteConfiguration {
  static List<Path> paths = [
    Path(r'^/$', (context, matches) => WelcomePage()),
    Path(r'^/today$', (context, matches) => AppContainer(selectedIndex: 0,)),
    Path(r'^/random$', (context, matches) => AppContainer(selectedIndex: 1)),
    Path(r'^/stats/(?<pokemonId>[0-9]+)$', (context, matches) => PokemonStatsPage(pokemonId: int.parse(matches['pokemonId']))),
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

  static Route<dynamic> onGeneratePage(RouteSettings settings) {
    for (Path path in paths) {
      final regExpPattern = RegExp(path.pattern);
      if (regExpPattern.hasMatch(settings.name)) {
        final match = regExpPattern.firstMatch(settings.name);
        Map<String, String> groupNameToMatch = {};
        for (String groupName in match.groupNames) {
          groupNameToMatch[groupName] = match.namedGroup(groupName);
        }
        pages.add(NavigatorPage(page: path.builder(containerKey.currentState.context, groupNameToMatch)));
        // MaterialPageRoute<void>(
        //   builder: (context) => path.builder(context, groupNameToMatch),
        //   settings: settings,
        // );
      }
    }

    return null;
  }
}