import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_pokedex/routes.dart';
import 'package:flutter_pokedex/screens/randomPokemon/randomPokemon.dart';
import 'package:flutter_pokedex/screens/todayPokemon/todayPokemon.dart';
import 'package:flutter_pokedex/theme/appConstants.dart';

class RouteOption {
  RouteOption({Key key, this.route, this.page});

  String route;
  dynamic page;
}

class AppContainer extends StatefulWidget {
  AppContainer({Key key, @required this.selectedIndex}) : super(key: key);

  final int selectedIndex;

  @override
  _ContainerPageState createState() => _ContainerPageState();
}

class _ContainerPageState extends State<AppContainer> {
  GlobalKey<NavigatorState> navigator = GlobalKey();
  int _selectedIndex;
  List<RouteOption> _routesOptions;

  @override
  void initState() {
    super.initState();
    setState(() {
      _routesOptions = [
        RouteOption(route: '/today', page: TodayPokemonPage()),
        RouteOption(route: '/random', page: RandomPokemonPage()),
      ];
      _selectedIndex = widget.selectedIndex;
      Future.delayed(Duration(milliseconds: 25))
          .then((value) => _onItemTapped(_selectedIndex));
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // GlobalKey ref: https://stackoverflow.com/a/55218112
      navigator.currentState.push(MaterialPageRoute(
        builder: (context) => _routesOptions[index].page,
      ));
    });
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: Container(
            padding: EdgeInsets.only(top: 0),
            child: Expanded(
              child: Navigator(
                key: navigator,
                initialRoute: '/',
                onUnknownRoute: (RouteSettings settings) {
                  return MaterialPageRoute(
                      builder: (context) => TodayPokemonPage(),
                      settings: settings);
                },
                onGenerateRoute: RouteConfiguration.onGenerateRoute,
              ),
            )),
        bottomNavigationBar: new Theme(
          data: Theme.of(context).copyWith(
              // sets the background color of the `BottomNavigationBar`
              canvasColor: Colors.black,
              // sets the active color of the `BottomNavigationBar` if `Brightness` is light
              primaryColor: AppConstants.buttonColor,
              textTheme: Theme.of(context).textTheme.copyWith(
                  caption: new TextStyle(
                      color: Colors
                          .white))), // sets the inactive color of the `BottomNavigationBar`
          child: new BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.today),
                title: Text(
                  'Today',
                  style: TextStyle(fontSize: 10.0),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.refresh),
                title: Text('Random', style: TextStyle(fontSize: 10.0)),
              ),
            ],
          ),
        ),
      ),
      onWillPop: () async {
        return !await navigator.currentState.maybePop();
      },
    );
  }
}
