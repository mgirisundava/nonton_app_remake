import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nonton_app/models/movie_model.dart';
import 'package:http/http.dart' as http;

class MoviesProvider with ChangeNotifier {
  final String apiKey = 'ab3a67a225bfc7da852014189004fcb5';

// ignore: todo
// TODO : NOW PLAYING MOVIES

  List<MovieModel> _nowPlayingMovies = [];
  List<MovieModel> get nowPlayingMovies => _nowPlayingMovies;
  int get nowPlayingMoviesLength => _nowPlayingMovies.length;

  Future<void> getNowPlayingMovies() async {
    try {
      final url = Uri.parse(
          'https://api.themoviedb.org/3/movie/now_playing?api_key=$apiKey&language=en-US&page=1');
      final res = await http.get(url);
      final resData = (jsonDecode(res.body) as Map<String, dynamic>)['results'];
      if (resData == null) {
        return;
      }
      List<MovieModel> _loadedNowPlayingMovies = [];
      resData.forEach((value) {
        _loadedNowPlayingMovies.add(MovieModel(
          id: value['id'],
          title: value['title'] ?? value['original_title'],
          originalTitle: value['original_title'] ?? 'No Data',
          posterPath: value["poster_path"] != null
              ? 'https://image.tmdb.org/t/p/w500' + value["poster_path"]
              : null,
          backdropPath: value["backdrop_path"] != null
              ? 'https://image.tmdb.org/t/p/w500' + value["backdrop_path"]
              : null,
          voteAverage: value['vote_average'] ?? 0.0,
          voteCount: value['vote_count'] ?? 0,
          releaseDate: DateTime.parse(
            value['release_date'],
          ),
        ));
      });

      _nowPlayingMovies = _loadedNowPlayingMovies;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

// ignore: todo
// TODO : POPULAR MOVIE

  List<MovieModel> _popularMovies = [];
  List<MovieModel> get popularMovies => _popularMovies;
  int get popularMoviesLength => _popularMovies.length;

  Future<void> getPopularMovies() async {
    Uri url = Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=$apiKey&language=en-US&page=1');

    try {
      final response = await http.get(url);
      final extractedData =
          (json.decode(response.body) as Map<String, dynamic>)["results"];

      final List<MovieModel> _loadedPopularMovies = [];
      if (extractedData == null) {
        return;
      }
      extractedData.forEach(
        (value) {
          _loadedPopularMovies.add(
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
      _popularMovies = _loadedPopularMovies;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

// ignore: todo
// TODO : TOP RATED MOVIES

  List<MovieModel> _topRatedMovies = [];
  List<MovieModel> get topRatedMovies => _topRatedMovies;
  int get topRatedMoviesLength => _topRatedMovies.length;

  Future<void> getTopRatedMovies() async {
    Uri url = Uri.parse(
        'https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey&language=en-US&page=1');

    try {
      final response = await http.get(url);
      final extractedData =
          (json.decode(response.body) as Map<String, dynamic>)["results"];

      final List<MovieModel> _laodedTopRatedMovies = [];
      if (extractedData == null) {
        return;
      }
      extractedData.forEach(
        (value) {
          _laodedTopRatedMovies.add(
            MovieModel(
              id: value['id'],
              posterPath: value['poster_path'] == null
                  ? null
                  : 'https://image.tmdb.org/t/p/w500' + value["poster_path"],
              title: value['title'] ?? value['original_title'],
              backdropPath: value['backdrop_path'] == null
                  ? null
                  : 'https://image.tmdb.org/t/p/w500' + value["backdrop_path"],
              originalTitle: value['original_title'] ?? value['title'],
              voteAverage: value['vote_average'] ?? 0.0,
              voteCount: value['vote_count'] ?? 0,
              releaseDate: DateTime.parse(
                value['release_date'],
              ),
            ),
          );
        },
      );
      _topRatedMovies = _laodedTopRatedMovies;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

// ignore: todo
// TODO : POPULAR MOVIE

  List<MovieModel> _upcomingMovies = [];
  List<MovieModel> get upcomingMovies => _upcomingMovies;
  int get upcomingMoviesLength => _upcomingMovies.length;

  Future<void> getUpcomingMovies() async {
    Uri url = Uri.parse(
        'https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey&language=en-US&page=1');

    try {
      final response = await http.get(url);
      final extractedData =
          (json.decode(response.body) as Map<String, dynamic>)["results"];

      final List<MovieModel> _loadedUpcomingMovies = [];
      if (extractedData == null) {
        return;
      }
      extractedData.forEach(
        (value) {
          _loadedUpcomingMovies.add(
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
      _upcomingMovies = _loadedUpcomingMovies;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
