import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/credit_model.dart';
import '../models/movie_model.dart';

class SeeAllProvider with ChangeNotifier {
  final String apiKey = 'ab3a67a225bfc7da852014189004fcb5';

// ignore: todo
// TODO : POPULAR MOVIE

  List<MovieModel> _seeAllMovies = [];
  List<MovieModel> get seeAllMovies => _seeAllMovies;
  int get seeAllMoviesLength => _seeAllMovies.length;

  Future<void> getSeeAllMovies(String category, int pageIndex) async {
    Uri url = Uri.parse(
        'https://api.themoviedb.org/3/movie/$category?api_key=$apiKey&language=en-USpage=$pageIndex');

    try {
      final response = await http.get(url);
      final extractedData =
          (json.decode(response.body) as Map<String, dynamic>)["results"];

      final List<MovieModel> _loadedSeeAllMovies = [];
      if (extractedData == null) {
        return;
      }
      extractedData.forEach(
        (value) {
          _loadedSeeAllMovies.add(
            MovieModel(
              id: value['id'],
              posterPath: value['poster_path'] == null
                  ? null
                  : 'https://image.tmdb.org/t/p/w500' + value["poster_path"],
              title: value['title'] ?? value['original_title'],
              backdropPath: value['backdrop_path'] == null
                  ? null
                  : 'https://image.tmdb.org/t/p/w500' + value["backdrop_path"],
              originalTitle: value['original_title'] ?? value['No Data'],
              voteAverage: value['vote_average'] ?? 0.0,
              voteCount: value['vote_count'] ?? 0,
            ),
          );
        },
      );
      _seeAllMovies = _loadedSeeAllMovies;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

// ignore: todo
// TODO : SEE ALL CREDIT

  List<CreditModel> _seeAllCredits = [];
  List<CreditModel> get seeAllCredits => _seeAllCredits;
  int get seeAllCreditsLength => _seeAllCredits.length;

  Future<void> getSeeAllCredits(int id, String mediaType) async {
    Uri url = Uri.parse(
        'https://api.themoviedb.org/3/$mediaType/$id/credits?api_key=$apiKey&language=en-US');

    try {
      final response = await http.get(url);
      final extractedData =
          (json.decode(response.body) as Map<String, dynamic>)["cast"];

      final List<CreditModel> _loadedSeeAllCredit = [];
      if (extractedData == null) {
        return;
      }
      extractedData.forEach(
        (value) {
          _loadedSeeAllCredit.add(
            CreditModel(
              id: value['id'],
              profilePath: value['profile_path'] == null
                  ? null
                  : 'https://image.tmdb.org/t/p/w500' + value["profile_path"],
              name: value['name'] ?? value['original_name'],
              character: value['character'] ?? value['job'],
              job: value['job'] ?? 'No Data',
            ),
          );
        },
      );
      _seeAllCredits = _loadedSeeAllCredit;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
