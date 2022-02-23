class MovieModel {
  int id;
  String? title;
  String? originalTitle;
  String? posterPath;
  String? backdropPath;
  num? voteAverage;
  num? voteCount;
  DateTime? releaseDate;

  MovieModel({
    required this.id,
    this.title,
    this.originalTitle,
    this.posterPath,
    this.backdropPath,
    this.voteAverage,
    this.voteCount,
    this.releaseDate,
  });
}
