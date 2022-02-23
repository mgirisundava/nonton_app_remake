class CreditModel {
  // bool adult;
  // num gender;
  int id;
  // Department knownForDepartment;
  String name;
  // String originalName;
  // double popularity;
  String? profilePath;
  // num castId;
  String character;
  // String creditId;
  // num order;
  // Department department;
  String job;
  CreditModel({
    // required this.adult,
    // required this.gender,
    required this.id,
    // required this.knownForDepartment,
    required this.name,
    // required this.originalName,
    // required this.popularity,
    this.profilePath,
    // required this.castId,
    required this.character,
    // required this.creditId,
    // required this.order,
    // required this.department,
    required this.job,
  });
}
