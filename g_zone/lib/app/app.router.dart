// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:g_zone/models/game_info.dart';
import 'package:g_zone/ui/card/card_view.dart';
import 'package:g_zone/ui/start_up/default_page.dart';
import 'package:stacked/stacked.dart';

import '../ui/home/home.dart';
import '../ui/start_up/startup_view.dart';

class Routes {
  static const String startUpView = '/';
  static const String homeView = '/home-view';
  static const String cardView = '/card-view';
  static const String defaultPage = '/default-view';
  static const all = <String>{
    startUpView,
    homeView,
    cardView,
    defaultPage,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.startUpView, page: StartUpView),
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.cardView, page: CardView),
    RouteDef(Routes.defaultPage, page: defaultPage),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    StartUpView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const StartUpView(),
        settings: data,
      );
    },
    HomeView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => HomeView(),
        settings: data,
      );
    },
    defaultPage: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => defaultPage(),
        settings: data,
      );
    },
    CardView: (data) {
      var args = data.getArgs<CardViewArguments>(
        orElse: () => CardViewArguments(gameInformation:  GameInformation(
            name: 'apex Legends',
            genres: 'Action',
            releaseDate: '22-4-2012',
            negativeRatings: 120,
            categories: 'Single-player',
            positiveRatings: 150,
            price: 5.3,
            owners: '5000000-10000000'
        )),
      );
      return CupertinoPageRoute<dynamic>(
        builder: (context) => CardView(
          key: args.key,
          inf: args.gameInformation,
        ),
        settings: data,
      );
    },
  };
}

class CardViewArguments {
  final Key? key;
  final GameInformation gameInformation;

  CardViewArguments({this.key, required this.gameInformation});
}
