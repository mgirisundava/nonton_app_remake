class TvDetailGenre {
  int id;
  String name;
  TvDetailGenre({
    required this.id,
    required this.name,
  });
}

class TvDetailSeason {
  int id;
  String name;
  DateTime? airDate;
  String? posterPath;
  int seasonNumber;
  int episdoeCount;

  TvDetailSeason({
    required this.id,
    required this.name,
    required this.airDate,
    required this.posterPath,
    required this.seasonNumber,
    required this.episdoeCount,
  });
}
