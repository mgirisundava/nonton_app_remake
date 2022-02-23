import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nonton_app/models/tv_detail_model.dart';

import '../models/credit_model.dart';
import '../models/review_model.dart';
import '../models/video_model.dart';

class TvDetailProvider with ChangeNotifier {
  final String apiKey = 'ab3a67a225bfc7da852014189004fcb5';

// ignore: todo
// TODO : TV DETAIL

  Map<String, dynamic> _tvDetail = {};
  Map<String, dynamic> get tvDetail => _tvDetail;

// ignore: todo
// TODO : TV GENRES

  List<TvDetailGenre> _tvGenres = [];
  List<TvDetailGenre> get tvGenres => _tvGenres;
  int get tvGenresLength => _tvGenres.length;

// ignore: todo
// TODO : TV SEASONS

  List<TvDetailSeason> _tvSeasons = [];
  List<TvDetailSeason> get tvSeasons => _tvSeasons;
  int get tvSeasonsLength => _tvSeasons.length;

  Future<void> getTvDetail(int id) async {
    try {
      final res = await http.get(
        Uri.parse(
            'https://api.themoviedb.org/3/tv/$id?api_key=$apiKey&language=en-US'),
      );
      final resData = jsonDecode(res.body);
      _tvDetail = resData;

      final resDataGenres =
          (jsonDecode(res.body) as Map<String, dynamic>)['genres'];
      if (resDataGenres == null) {
        return;
      }

      List<TvDetailGenre> _loadedTvGenres = [];

      resDataGenres.forEach(
        (value) {
          _loadedTvGenres.add(
            TvDetailGenre(
              id: value['id'],
              name: value['name'],
            ),
          );
        },
      );

      _tvGenres = _loadedTvGenres;

      final resDataSeasons =
          (jsonDecode(res.body) as Map<String, dynamic>)['seasons'];
      if (resDataSeasons == null) {
        return;
      }

      List<TvDetailSeason> _loadedTvSeasons = [];

      resDataSeasons.forEach(
        (value) {
          _loadedTvSeasons.add(
            TvDetailSeason(
              id: value['id'],
              name: value['name'],
              airDate: value['air_date'] != null
                  ? DateTime.parse(value['air_date'])
                  : null,
              posterPath: value["poster_path"] != null
                  ? 'https://image.tmdb.org/t/p/w500' + value["poster_path"]
                  : null,
              seasonNumber: value['season_number'],
              episdoeCount: value['episode_count'],
            ),
          );
        },
      );

      _tvSeasons = _loadedTvSeasons;

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

// ignore: todo
// TODO : TV SHOW REVIEW

  List<ReviewModel> _tvReview = [];
  List<ReviewModel> get tvReview => _tvReview;
  int get tvReviewLength => _tvReview.length;

  Future<void> getTvReview(int id) async {
    Uri url = Uri.parse(
        'https://api.themoviedb.org/3/tv/$id/reviews?api_key=$apiKey&language=en-US');

    try {
      final response = await http.get(url);
      final extractedData =
          (json.decode(response.body) as Map<String, dynamic>)["results"];

      List<ReviewModel> _loadedTvReview = [];
      if (extractedData == null) {
        return;
      }

      extractedData.forEach(
        (value) {
          _loadedTvReview.add(
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

      _tvReview = _loadedTvReview;

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  // ignore: todo
// TODO : TV VIDEO

  List<VideoModel> _tvVideo = [];
  List<VideoModel> get tvVideo => _tvVideo;
  int get tvVideoLength => _tvVideo.length;

  Future<void> getTvVideo(int id) async {
    Uri url = Uri.parse(
        'https://api.themoviedb.org/3/tv/$id/videos?api_key=$apiKey&language=en-US');

    try {
      final response = await http.get(url);
      final extractedData =
          (json.decode(response.body) as Map<String, dynamic>)["results"];

      final List<VideoModel> _loadedTvVideo = [];
      if (extractedData == null) {
        return;
      }
      extractedData.forEach(
        (value) {
          _loadedTvVideo.add(
            VideoModel(
              id: value['id'],
              name: value['name'] ?? '',
              key: value['key'] ?? '',
            ),
          );
        },
      );
      _tvVideo = _loadedTvVideo;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

// ignore: todo
// TODO : TV CREDIT

  List<CreditModel> _tvCredit = [];
  List<CreditModel> get tvCredit => _tvCredit;
  int get tvCreditLength => _tvCredit.length;

  Future<void> getTvCredit(int id) async {
    Uri url = Uri.parse(
        'https://api.themoviedb.org/3/tv/$id/credits?api_key=$apiKey&language=en-US');

    try {
      final response = await http.get(url);
      final extractedData =
          (json.decode(response.body) as Map<String, dynamic>)["cast"];

      final List<CreditModel> _loadedTvCredit = [];
      if (extractedData == null) {
        return;
      }
      extractedData.forEach(
        (value) {
          _loadedTvCredit.add(
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
      _tvCredit = _loadedTvCredit;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
