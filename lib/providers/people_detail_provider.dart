import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PersonDetailProvider with ChangeNotifier {
  final String apiKey = 'ab3a67a225bfc7da852014189004fcb5';

  Map<String, dynamic> _personDetail = {};
  Map<String, dynamic> get personDetail => _personDetail;

  Future<void> getPersonDetail(int id) async {
    try {
      final res = await http.get(
        Uri.parse(
            'https://api.themoviedb.org/3/person/$id?api_key=$apiKey&language=en-US'),
      );
      final resData = jsonDecode(res.body);
      _personDetail = resData;

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
