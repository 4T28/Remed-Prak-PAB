class ArticleModel {
  final int id;
  final String title;
  final String imageUrl;
  final String summary;
  final String newsSite;
  final String publishedAt;

  ArticleModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.summary,
    required this.newsSite,
    required this.publishedAt,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      imageUrl: json['image_url']?.toString() ?? '',
      summary: json['summary']?.toString() ?? '',
      newsSite: json['news_site']?.toString() ?? '',
      publishedAt: json['published_at']?.toString() ?? '',
    );
  }
}

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String instagram;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.instagram,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      instagram: map['instagram'] ?? '',
    );
  }
}