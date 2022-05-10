import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:g_zone/app/app.locator.dart';
import 'package:g_zone/app/app.logger.dart';
import 'package:g_zone/app/app.router.dart';
import 'package:g_zone/models/game_info.dart';
import 'package:g_zone/models/room.dart';
import 'package:stacked_services/stacked_services.dart';

class RoomCardShape extends StatefulWidget {
  final GameInformation inf;
  final RoomInformation roomInformation;
  RoomCardShape({required this.inf, required this.roomInformation});
  @override
  _RoomCardShapeState createState() => _RoomCardShapeState(inf: this.inf, roomInformation: roomInformation);
}

class _RoomCardShapeState extends State<RoomCardShape> {

  final navigationService = locator<NavigationService>();
  final log = getLogger('RoomCardShape');
  bool liked = false;

  final GameInformation inf;
  final RoomInformation roomInformation;
  _RoomCardShapeState({ required this.inf, required this.roomInformation});

  Widget textShape(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width*0.7,
      height: 110,
      padding: const EdgeInsets.only(left: 25, bottom: 10, top: 10),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              roomInformation.title,
              style: const TextStyle(fontFamily: 'Cairo', fontSize: 18, color: Colors.white),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              inf.name,
              style: const TextStyle(fontFamily: 'Cairo', fontSize: 14, color: Colors.white),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              roomInformation.currentCount.toString() + '/' + roomInformation.capacity.toString(),
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
                    color: const Color.fromRGBO(165, 132, 250, 1.0),
                    icon: const Icon(Icons.check_circle_outline_rounded),
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
                    icon: const Icon(Icons.add_circle_outline_rounded),
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