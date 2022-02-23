class TvModel {
  int id;
  String? name;
  String? originalName;
  String? posterPath;
  String? backdropPath;
  num? voteAverage;
  num? voteCount;
  DateTime? firstAirDate;

  TvModel({
    required this.id,
    this.name,
    this.originalName,
    this.posterPath,
    this.backdropPath,
    this.voteAverage,
    this.voteCount,
    this.firstAirDate,
  });
}
