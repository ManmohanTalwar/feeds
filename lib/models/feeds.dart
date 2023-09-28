import 'package:feeds/main.dart';

class Feeds {
  String? title;
  List<FeedData>? rows;

  Feeds({
    this.title,
    this.rows,
  });

  factory Feeds.fromJson(Map<String, dynamic> json) => Feeds(
        title: json['title'] ?? '',
        rows: (json['rows'] as List? ?? [])
            .map((e) => FeedData.fromJson(e))
            .toList(),
      );

  Map toJson() => {
        'title': title,
        'rows': rows?.map((e) => e.toJson()),
      };
}

class FeedData {
  final String? title;
  final String? description;
  final String? imageHref;

  FeedData({
    this.title,
    this.description,
    this.imageHref,
  });

  factory FeedData.fromJson(Map<String, dynamic> json) => FeedData(
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        imageHref: json['imageHref'] ?? '',
      );

  /// to check for incorrect/incomplete records
  bool isEmpty() =>
      title.isNullOrEmpty() &&
      description.isNullOrEmpty() &&
      imageHref.isNullOrEmpty();

  Map toJson() => {
        'title': title,
        'description': description,
        'imageHref': imageHref,
      };
}
