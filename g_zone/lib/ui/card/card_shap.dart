import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:g_zone/app/app.locator.dart';
import 'package:g_zone/app/app.logger.dart';
import 'package:g_zone/models/game_info.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:g_zone/app/app.router.dart';

class CardShape extends StatefulWidget {
  final GameInformation inf;
  CardShape({required this.inf});
  @override
  _CardShapeState createState() => _CardShapeState(inf: this.inf);
}

class _CardShapeState extends State<CardShape> {

  final navigationService = locator<NavigationService>();
  final log = getLogger('CardShape');
  bool liked = false;

  final GameInformation inf;
  _CardShapeState({ required this.inf });

  Widget textShape(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width*0.7,
      height: 90,
      padding: const EdgeInsets.only(left: 25, bottom: 10, top: 10),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              inf.name,
              style: const TextStyle(fontFamily: 'Cairo', fontSize: 18, color: Colors.white),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              inf.releaseDate,
              style: const TextStyle(fontFamily: 'Cairo', fontSize: 14, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0.0),
      child: GestureDetector(
        onTap: () {
          navigationService.navigateTo(Routes.cardView, arguments: CardViewArguments(gameInformation: inf));
        },
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          height: 200,
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: const BorderRadius.all(Radius.circular(18.0)),
            border: Border.all(color: const Color.fromRGBO(165, 132, 250, 1.0), width: 0.8),
          ),
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(18.0)),
                  image: DecorationImage(
                      colorFilter: ColorFilter.mode(Color.fromRGBO(0, 0, 0, 0.7), BlendMode.darken),
                      image: AssetImage("assets/images/apex.png"),
                      fit: BoxFit.cover),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 120,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(18.0)),
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black,
                            Color.fromRGBO(0, 0, 0, 0.0)
                          ]
                      )
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: textShape(context),
              ),
              (liked ? Container(
                padding: const EdgeInsets.only(right: 15, bottom: 10),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    iconSize: 30,
                    color: Colors.redAccent,
                    icon: const Icon(Icons.favorite),
                    onPressed: () {
                      setState(() {
                        liked = !liked;
                      });
                    },
                  ),
                ),
              ) : Container(
                padding: const EdgeInsets.only(right: 15, bottom: 10),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    iconSize: 30,
                    color: Colors.white,
                    icon: const Icon(Icons.favorite_border),
                    onPressed: () {
                      setState(() {
                        liked = !liked;
                      });
                    },
                  ),
                ),
              )
              ),
            ],
          ),
        ),
      ),
    );
  }
}