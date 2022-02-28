import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../config/const.dart';
import '../pages/main_page.dart';

class AuthProvider with ChangeNotifier {
  final String apiKey = 'ab3a67a225bfc7da852014189004fcb5';

  Future<void> requestToken(
    BuildContext context,
    String username,
    String password,
  ) async {
    Uri url =
        Uri.parse('${Const.baseUrl}authentication/token/new?api_key=$apiKey');

    try {
      final response = await http.get(url);

      final responseData = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        login(context, username, password, responseData['request_token']);
      } else {
        throw responseData["status_message"];
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<void> login(BuildContext context, String username, String password,
      String requestToken) async {
    Uri url = Uri.parse(
        '${Const.baseUrl}authentication/token/validate_with_login?api_key=$apiKey');
    try {
      var params = {
        'username': username,
        'password': password,
        'request_token': requestToken
      };
      final response = await http.post(
        url,
        body: params,
      );
      final responseData = json.decode(response.body);
      print(responseData);
      if (response.statusCode == 200) {
        checkSession(context, requestToken);
      } else {
        throw responseData["status_message"];
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> checkSession(BuildContext context, String? requestToken) async {
    Uri url =
        Uri.parse('${Const.baseUrl}authentication/session/new?api_key=$apiKey');
    try {
      final response = await http.post(url, body: {
        'request_token': requestToken,
      });
      print(response);
      if (response.statusCode == 200) {
        final sharedPref = await SharedPreferences.getInstance();
        final responseData = jsonDecode(response.body) as Map<String, dynamic>;
        sharedPref.setString(
          '@sessionId',
          responseData['session_id'],
        );
        if (requestToken!.isNotEmpty) {
          sharedPref.setString(
            '@requestToken',
            requestToken,
          );
          Navigator.pushReplacementNamed(context, MainPage.routeName);
        } else {
          throw responseData["status_message"];
        }
      }
    } catch (e) {
      throw e;
    }
  }
}
