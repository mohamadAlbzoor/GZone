import 'dart:convert';

import 'package:g_zone/app/app.logger.dart';
import 'package:g_zone/models/search_suggestion.dart';
import 'package:http/http.dart' as http;

class SearchApi {
  static Future<List<SearchSuggestion>> getSearchSuggestions(String query) async {

    if(query=="")return List<SearchSuggestion>.empty();

    final log = getLogger('Search');
    log.i("test ...");

    final url = Uri.parse('https://mocki.io/v1/a0d3e01a-7de1-4091-ba0c-2efc698403d2');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List results = json.decode(response.body);
      return results.map((json) => SearchSuggestion.fromJson(json)).toList();

    } else {
      throw Exception();
    }
  }
}