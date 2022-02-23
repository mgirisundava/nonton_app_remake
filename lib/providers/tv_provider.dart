import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nonton_app/models/tv_model.dart';

class TvProvider with ChangeNotifier {
  final String apiKey = 'ab3a67a225bfc7da852014189004fcb5';

// ignore: todo
// TODO : ON TV

  List<TvModel> _tvOnTv = [];
  List<TvModel> get tvOnTv => _tvOnTv;
  int get tvOnTvLength => _tvOnTv.length;

  Future<void> getTvOnTv() async {
    try {
      final url = Uri.parse(
          'https://api.themoviedb.org/3/tv/on_the_air?api_key=$apiKey&language=en-US&page=1');
      final res = await http.get(url);
      final resData = (jsonDecode(res.body) as Map<String, dynamic>)['results'];
      if (resData == null) {
        return;
      }
      List<TvModel> _loadedTvOnTv = [];
      resData.forEach(
        (value) {
          _loadedTvOnTv.add(
            TvModel(
              id: value['id'],
              name: value['name'] ?? value['original_name'],
              originalName: value['original_name'] ?? 'No Data',
              posterPath: value["poster_path"] != null
                  ? 'https://image.tmdb.org/t/p/w500' + value["poster_path"]
                  : null,
              backdropPath: value["backdrop_path"] != null
                  ? 'https://image.tmdb.org/t/p/w500' + value["backdrop_path"]
                  : null,
              voteAverage: value['vote_average'] ?? 0.0,
              voteCount: value['vote_count'] ?? 0,
              firstAirDate: DateTime.parse(
                value['first_air_date'],
              ),
            ),
          );
        },
      );

      _tvOnTv = _loadedTvOnTv;

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

// ignore: todo
// TODO : POPULAR TV

  List<TvModel> _tvPopular = [];
  List<TvModel> get tvPopular => _tvPopular;
  int get tvPopularLength => _tvPopular.length;

  Future<void> getTvPopular() async {
    Uri url = Uri.parse(
        'https://api.themoviedb.org/3/tv/popular?api_key=$apiKey&language=en-US&page=1');

    try {
      final response = await http.get(url);
      final extractedData =
          (json.decode(response.body) as Map<String, dynamic>)["results"];

      final List<TvModel> _loadedTvPopular = [];
      if (extractedData == null) {
        return;
      }
      extractedData.forEach(
        (value) {
          _loadedTvPopular.add(
            TvModel(
              id: value['id'],
              posterPath: value['poster_path'] == null
                  ? null
                  : 'https://image.tmdb.org/t/p/w500' + value["poster_path"],
              name: value['name'] ?? value['original_name'],
              backdropPath: value['backdrop_path'] == null
                  ? null
                  : 'https://image.tmdb.org/t/p/w500' + value["backdrop_path"],
              originalName: value['original_name'] ?? value['name'],
              voteAverage: value['vote_average'] ?? 0.0,
              voteCount: value['vote_count'] ?? 0,
            ),
          );
        },
      );
      _tvPopular = _loadedTvPopular;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

// ignore: todo
// TODO : TOP RATED TV SHOWS

  List<TvModel> _tvTopRated = [];
  List<TvModel> get tvTopRated => _tvTopRated;
  int get tvTopRatedLength => _tvTopRated.length;

  Future<void> getTvTopRated() async {
    Uri url = Uri.parse(
        'https://api.themoviedb.org/3/tv/top_rated?api_key=$apiKey&language=en-US&page=1');

    try {
      final response = await http.get(url);
      final extractedData =
          (json.decode(response.body) as Map<String, dynamic>)["results"];

      final List<TvModel> _loadedTvTopRated = [];
      if (extractedData == null) {
        return;
      }
      extractedData.forEach(
        (value) {
          _loadedTvTopRated.add(
            TvModel(
              id: value['id'],
              posterPath: value['poster_path'] == null
                  ? null
                  : 'https://image.tmdb.org/t/p/w500' + value["poster_path"],
              name: value['name'] ?? value['original_name'],
              backdropPath: value['backdrop_path'] == null
                  ? null
                  : 'https://image.tmdb.org/t/p/w500' + value["backdrop_path"],
              originalName: value['original_name'] ?? value['name'],
              voteAverage: value['vote_average'] ?? 0.0,
              voteCount: value['vote_count'] ?? 0,
              firstAirDate: DateTime.parse(
                value['first_air_date'],
              ),
            ),
          );
        },
      );
      _tvTopRated = _loadedTvTopRated;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
