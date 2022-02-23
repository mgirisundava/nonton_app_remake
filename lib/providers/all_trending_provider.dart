import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nonton_app/models/all_trending_model.dart';
import 'package:http/http.dart' as http;

class AllTrendingProvider with ChangeNotifier {
  final String apiKey = 'ab3a67a225bfc7da852014189004fcb5';

// ignore: todo
// TODO :  ALL TRENDING PROVIDER

  List<AllTrendingModel> _allTrending = [];
  List<AllTrendingModel> get allTrending => _allTrending;
  int get allTrendingLength => _allTrending.length;

  Future<void> getAllTrendingProvider() async {
    try {
      final url = Uri.parse(
          'https://api.themoviedb.org/3/trending/all/day?api_key=$apiKey');
      final res = await http.get(url);
      final resData = (jsonDecode(res.body) as Map<String, dynamic>)['results'];
      if (resData == null) {
        return;
      }
      List<AllTrendingModel> _loadedAllTrendingProvider = [];
      resData.forEach(
        (value) {
          _loadedAllTrendingProvider.add(
            AllTrendingModel(
              id: value['id'],
              title: value['title'] ?? value['name'],
              originalTitle: value['original_title'] ?? '-',
              backdropPath: value["backdrop_path"] != null
                  ? 'https://image.tmdb.org/t/p/w500' + value["backdrop_path"]
                  : null,
              name: value['name'] ?? '-',
              originalName: value['original_name'] ?? '-',
              mediaType: value['media_type'],
            ),
          );
        },
      );

      _allTrending = _loadedAllTrendingProvider;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
