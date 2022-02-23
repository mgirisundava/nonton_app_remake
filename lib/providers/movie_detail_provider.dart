import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nonton_app/models/movie_detail_model.dart';
import 'package:nonton_app/models/video_model.dart';

import '../models/credit_model.dart';
import '../models/review_model.dart';

class MovieDetailProvider with ChangeNotifier {
  final String apiKey = 'ab3a67a225bfc7da852014189004fcb5';

  Map<String, dynamic> _movieDetail = {};
  Map<String, dynamic> get movieDetail => _movieDetail;

  List<MovieDetailGenre> _movieGenres = [];
  List<MovieDetailGenre> get movieGenres => _movieGenres;
  int get movieGenresLength => _movieGenres.length;

  Future<void> getMovieDetail(int id) async {
    try {
      final res = await http.get(
        Uri.parse(
            'https://api.themoviedb.org/3/movie/$id?api_key=$apiKey&language=en-US'),
      );
      final resData = jsonDecode(res.body);
      _movieDetail = resData;

      final resDataGenres =
          (jsonDecode(res.body) as Map<String, dynamic>)['genres'];
      if (resDataGenres == null) {
        return;
      }

      List<MovieDetailGenre> _loadedMovieGenres = [];

      resDataGenres.forEach(
        (value) {
          _loadedMovieGenres.add(
            MovieDetailGenre(
              id: value['id'],
              name: value['name'],
            ),
          );
        },
      );

      _movieGenres = _loadedMovieGenres;

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

// ignore: todo
// TODO : MOVIE REVIEW

  List<ReviewModel> _movieReview = [];
  List<ReviewModel> get movieReview => _movieReview;
  int get movieReviewLength => _movieReview.length;

  Future<void> getMovieReview(int id) async {
    Uri url = Uri.parse(
        'https://api.themoviedb.org/3/movie/$id/reviews?api_key=$apiKey&language=en-US');

    try {
      final response = await http.get(url);
      final extractedData =
          (json.decode(response.body) as Map<String, dynamic>)["results"];

      List<ReviewModel> _laodedMovieReview = [];
      if (extractedData == null) {
        return;
      }

      extractedData.forEach(
        (value) {
          _laodedMovieReview.add(
            ReviewModel(
              id: value['id'],
              author: value['author'] == '' ? 'Anonymous' : value['author'],
              content: value['content'] ?? [''],
              url: value['url'] ?? [''],
              createdAt: DateTime.parse(
                value['created_at'],
              ),
            ),
          );
        },
      );

      _movieReview = _laodedMovieReview;

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

// ignore: todo
// TODO : MOVIE CREDIT

  List<CreditModel> _movieCredit = [];
  List<CreditModel> get movieCredit => _movieCredit;
  int get movieCreditLength => _movieCredit.length;

  Future<void> getMovieCredit(int id) async {
    Uri url = Uri.parse(
        'https://api.themoviedb.org/3/movie/$id/credits?api_key=$apiKey&language=en-US');

    try {
      final response = await http.get(url);
      final extractedData =
          (json.decode(response.body) as Map<String, dynamic>)["cast"];

      final List<CreditModel> _loadedMovieCredit = [];
      if (extractedData == null) {
        return;
      }
      extractedData.forEach(
        (value) {
          _loadedMovieCredit.add(
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
      _movieCredit = _loadedMovieCredit;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

// ignore: todo
// TODO : MOVIE VIDEO

  List<VideoModel> _movieVideo = [];
  List<VideoModel> get movieVideo => _movieVideo;
  int get movieVideoLength => _movieVideo.length;

  Future<void> getMovieVideo(int id) async {
    Uri url = Uri.parse(
        'https://api.themoviedb.org/3/movie/$id/videos?api_key=$apiKey&language=en-US');

    try {
      final response = await http.get(url);
      final extractedData =
          (json.decode(response.body) as Map<String, dynamic>)["results"];

      final List<VideoModel> _loadedMovieVideo = [];
      if (extractedData == null) {
        return;
      }
      extractedData.forEach(
        (value) {
          _loadedMovieVideo.add(
            VideoModel(
              id: value['id'],
              name: value['name'] ?? '',
              key: value['key'] ?? '',
            ),
          );
        },
      );
      _movieVideo = _loadedMovieVideo;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
