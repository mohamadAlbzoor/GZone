import 'dart:convert';

import 'package:g_zone/api/url.dart';
import 'package:g_zone/app/app.logger.dart';
import 'package:g_zone/models/search_suggestion.dart';
import 'package:http/http.dart' as http;

import '../models/jwt.dart';

class LoginApi {
  static Future<JWT> postLogin(String e, String p) async {
    //encode Map to JSON
    final log = getLogger('login');

    log.i("here1");

    final url = Uri.parse(URL.u + 'user/login');
    Map data = {'email': e, 'password': p};
    log.wtf("here2");

    var response = await http.post(url,
        headers: {"content-type": "application/json"}, body: json.encode(data));

    if (response.statusCode > 400) {
      final results = json.decode(response.body);
      log.i(results);

      return new JWT(jwt: "");
    } else if (response.statusCode > 200) {
      final results = json.decode(response.body);
      log.i(results);

      return JWT.fromJson(results);
    } else {
      throw Exception();
    }
  }
}
