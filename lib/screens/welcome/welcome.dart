import 'package:flutter/material.dart';

import 'package:flutter_pokedex/components/appButton.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Column(children: [
              Text(
              'Flutter Pokédex',
              style: Theme.of(context).textTheme.headline3,
            ),
            Text('Powered By:'),
            Image.asset('assets/images/pokeapi_256.png', fit: BoxFit.scaleDown,),
            ],),
            AppButton(text: 'Go To Home', icon: Icon(Icons.forward), route: '/today', removeHistory: true)
          ],
        ),
      ),
    );
  }
}
