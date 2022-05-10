import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:g_zone/api/search_api.dart';
import 'package:g_zone/app/app.logger.dart';
import 'package:g_zone/models/game_info.dart';
import 'package:g_zone/models/search_suggestion.dart';
import 'package:g_zone/ui/card/card_shap.dart';

class HomeView extends StatelessWidget {
  final searchController = TextEditingController();
  final log = getLogger('HomeView');

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery
        .of(context)
        .size;
    return Container(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(right: 12, left: 28),
            margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 16),
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(30)),
            child: Center(
              child: TypeAheadField<SearchSuggestion?>(
                hideSuggestionsOnKeyboardHide: true,
                debounceDuration: Duration(milliseconds: 500),
                textFieldConfiguration: TextFieldConfiguration(
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20.0,
                      height: 2.9,
                      color: Color.fromRGBO(89, 102, 125, 0.5),
                    ),
                    // prefixIcon: Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      color: Color(0xff192543),
                      iconSize: 35,
                      onPressed: () {
                        searchController.clear();
                      },
                    ),
                    border: InputBorder.none,
                    hintText: 'SEARCH',
                  ),

                  controller: searchController,
                ),
                suggestionsCallback: (pattern) async {
                  return await SearchApi.getSearchSuggestions(pattern);
                },
                itemBuilder: (context, SearchSuggestion? suggestion) {
                  final game = suggestion!;

                  return ListTile(
                    title: Text(game.name),
                  );
                },
                noItemsFoundBuilder: (context) =>
                    Container(
                      height: 100,
                      child: const Center(
                        child: Text(
                          'No Game Found.',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                onSuggestionSelected: (SearchSuggestion? suggestion) async {
                  log.wtf(suggestion);
                },
              ),
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CardShape(
                        inf: GameInformation(
                            name: 'Apex Legends',
                            genres: 'Action;Simulation',
                            releaseDate: '22-4-2012',
                            negativeRatings: 120,
                            categories: 'Multi-player;Online Multi-Player;Valve Anti-Cheat enabled kjfslk dslkmlkfml mdl;ksmfasl;dk lkamdalgmdslak;m lkdamlfma;dslm ',
                            positiveRatings: 150,
                            price: 5.3,
                            owners: '5000000-10000000'
                        )
                    ),
                    CardShape(
                        inf: GameInformation(
                            name: 'Bzoor number 1',
                            genres: 'Action',
                            releaseDate: '22-4-2012',
                            negativeRatings: 120,
                            categories: 'Single-player',
                            positiveRatings: 150,
                            price: 5.3,
                            owners: '5000000-10000000'
                        )
                    ),
                    CardShape(
                        inf: GameInformation(
                            name: 'offf another bzoor',
                            genres: 'Action',
                            releaseDate: '22-4-2012',
                            negativeRatings: 120,
                            categories: 'Single-player',
                            positiveRatings: 150,
                            price: 5.3,
                            owners: '5000000-10000000'
                        )
                    ),
                  ],
                ),
              )
          )
        ],
      ),
    );
  }
}