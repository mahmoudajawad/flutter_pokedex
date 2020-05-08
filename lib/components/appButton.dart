import 'package:flutter/material.dart';

import 'package:flutter_pokedex/theme/appConstants.dart';

class AppButton extends StatefulWidget {
  AppButton({Key key, @required this.text, @required this.icon, @required this.route, @required this.removeHistory})
      : super(key: key);

  final String text;
  final Icon icon;
  final String route;
  final bool removeHistory;

  @override
  _AppButtonState createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 54.0,
        margin:
            EdgeInsets.only(left: 28.0, right: 28.0, top: 50.0, bottom: 50.0),
        child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            onPressed: () {
              if (widget.removeHistory) {
                Navigator.pushNamedAndRemoveUntil(
                    context, widget.route, (route) => false);
              } else {
                Navigator.pushNamed(context, widget.route);
              }
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
                        widget.text,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(4, 0, 10, 0),
                        child: widget.icon),
                  ],
                ))));
  }
}
