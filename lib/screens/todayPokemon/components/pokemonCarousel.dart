import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter_pokedex/models/pokemon.dart';
import 'package:flutter_pokedex/models/pokemonSprites.dart';
import 'package:flutter_pokedex/utils/stringUtils.dart';

class PokemonCarousel extends StatefulWidget {
  PokemonCarousel({Key key, this.pokemon}) : super(key: key);

  final Pokemon pokemon;

  @override
  _PokemonCarouselState createState() => _PokemonCarouselState();
}

class _PokemonCarouselState extends State<PokemonCarousel> {
  int _current = 0;
  List<Widget> spritesSliders = [];

  @override
  void initState() {
    super.initState();
    // SO ref: https://stackoverflow.com/a/49578561/2393762
    spritesSliders = spritesList
        .where((sprite) => widget.pokemon.sprites.getProp(sprite) != null)
        .map((sprite) {
      return Container(
        child: Container(
          margin: EdgeInsets.all(5.0),
          child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              child: Stack(
                children: <Widget>[
                  Image.network(widget.pokemon.sprites.getProp(sprite),
                      fit: BoxFit.none, width: 1000.0),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(200, 0, 0, 0),
                            Color.fromARGB(0, 0, 0, 0)
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: Text(
                        capitalise(splitCamelCase('$sprite Sprite')),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CarouselSlider(
        items: spritesSliders,
        options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 2.0,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: spritesList
            .where((sprite) => widget.pokemon.sprites.getProp(sprite) != null)
            .map((sprite) {
          int index = spritesList.indexOf(sprite);
          return Container(
            width: 8.0,
            height: 8.0,
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _current == index
                  ? Color.fromRGBO(0, 0, 0, 0.9)
                  : Color.fromRGBO(0, 0, 0, 0.4),
            ),
          );
        }).toList(),
      ),
    ]);
  }
}
