import 'dart:convert';

import 'package:g_zone/app/app.logger.dart';
import 'package:g_zone/models/search_suggestion.dart';
import 'package:http/http.dart' as http;

import '../models/jwt.dart';

class SignupApi {
  static Future<JWT> postSingup(
      String user, String email, String p1, String p2) async {
    //encode Map to JSON

    final url = Uri.parse('URL.u+user/signUp');
    Map data = {
      'username': user,
      'email': email,
      'password': p1,
      'repeatPassword': p2
    };
    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);

    if (response.statusCode > 400) {
      final results = json.decode(response.body);
      final log = getLogger('signup');
      log.i(results);
      return new JWT(jwt: "");
    } else if (response.statusCode > 200) {
      final results = json.decode(response.body);
      return JWT.fromJson(results);
    } else {
      throw Exception();
    }
  }
}
