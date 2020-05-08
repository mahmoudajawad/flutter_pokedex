import 'package:flutter/material.dart';

import 'package:flutter_pokedex/theme/appConstants.dart';

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
            Container(
                height: 54.0,
                margin: EdgeInsets.only(
                    left: 28.0, right: 28.0, top: 50.0, bottom: 50.0),
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(context, '/today', (route) => false);
                    },
                    textColor: Colors.white,
                    color: AppConstants.buttonColor,
                    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.fromLTRB(4, 0, 10, 0),
                                child: Text('   ')),
                            Container(
                              color: Colors.transparent,
                              padding: EdgeInsets.fromLTRB(10, 4, 4, 4),
                              child: Text(
                                'GO TO HOME',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.fromLTRB(4, 0, 10, 0),
                                child: Icon(Icons.forward)),
                          ],
                        )))),
          ],
        ),
      ),
    );
  }
}
