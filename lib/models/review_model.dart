class ReviewModel {
  String author;
  String content;
  DateTime createdAt;
  String id;
  String url;
  ReviewModel({
    required this.author,
    required this.content,
    required this.createdAt,
    required this.id,
    required this.url,
  });
}

class AuthorDetails {
  String name;
  String username;
  String avatarPath;
  int rating;
  AuthorDetails({
    required this.name,
    required this.username,
    required this.avatarPath,
    required this.rating,
  });
}
