import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
}
