import 'source.dart';

class Article {
  Source source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;

  //Now let's create the constructor
  Article(
      {required this.source,
      required this.author,
      required this.title,
      required this.description,
      required this.url,
      required this.urlToImage,
      required this.publishedAt,
      required this.content});

  //And now let's create the function that will map the json into a list
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      source: Source.fromJson(json['source']),
      author: json['author'] as String? ?? 'No author',
      title: json['title'] as String? ?? 'No title',
      description: json['description'] as String? ?? 'No description',
      url: json['url'] as String? ?? 'No url',
      urlToImage: json['urlToImage'] as String? ?? 'No urlToImage',
      publishedAt: json['publishedAt'] as String? ?? 'No publishedAt',
      content: json['content'] as String? ?? 'No content',
    );
  }
}