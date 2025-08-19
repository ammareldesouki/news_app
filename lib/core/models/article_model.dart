class ArticleModel {
  final String status;
  final List<ArticleDetailesModel> sources;

  ArticleModel({
    required this.status,
    required this.sources,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      status: json["status"] ?? "",
      sources: (json["articles"] as List).map((data) {
        return ArticleDetailesModel.fromJson(data);
      }).toList(),
    );
  }
}

class ArticleDetailesModel {
  final String? author;
  final String title;
  final String? description;
  final String url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  ArticleDetailesModel({
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory ArticleDetailesModel.fromJson(Map<String, dynamic> json) {
    return ArticleDetailesModel(
      author: json["author"],
      title: json["title"] ?? "",
      description: json["description"],
      url: json["url"] ?? "",
      urlToImage: json["urlToImage"],
      publishedAt: json["publishedAt"] ,

      content: json["content"],
    );
  }
}
