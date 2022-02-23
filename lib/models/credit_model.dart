class CreditModel {
  int id;
  String name;
  String? profilePath;
  String character;
  String job;
  CreditModel({
    required this.id,
    required this.name,
    this.profilePath,
    required this.character,
    required this.job,
  });
}
