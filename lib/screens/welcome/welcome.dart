import 'dart:math';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage() : super();

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokémon of the Day'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Flutter Pokédex'),
            Text('Powered By:'),
            Image.asset('assets/images/pokeapi_256.png'),
            Expanded(
              child: FittedBox(),
            ),
            Container(
                height: 54.0,
                margin: EdgeInsets.only(
                    left: 28.0, right: 28.0, top: 50.0, bottom: 50.0),
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                      print('Button Clicked.');
                    },
                    textColor: Colors.black,
                    color: const Color(0xffA6814B),
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
                                child: Image.asset('assets/buttonforword.png')),
                          ],
                        )))),
          ],
        ),
      ),
    );
  }
}
