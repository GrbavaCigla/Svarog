import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:newsrs/models/article.dart';

Future<String?> getUser(String website, int? id) async {
  if (id == null) {
    return Future.value(null);
  }

  var url = Uri.parse(website + '/wp-json/wp/v2/users/$id');
  var response = await http.get(url);

  if (response.statusCode != 200) {
    // TODO: Make this better
    return Future.error("Status code not 200");
  }

  return Future.value(jsonDecode(response.body)["name"]);
}

Future<String?> getTag(String website, int? id) async {
  if (id == null) {
    return Future.value(null);
  }

  var url = Uri.parse(website + '/wp-json/wp/v2/categories/$id');
  var response = await http.get(url);

  if (response.statusCode != 200) {
    // TODO: Make this better
    return Future.error("Status code not 200");
  }

  return Future.value(jsonDecode(response.body)["name"]);
}

Future<List<Article>> getPosts(String website) async {
  var url = Uri.parse(website + '/wp-json/wp/v2/posts');
  var response = await http.get(url);

  if (response.statusCode != 200) {
    // TODO: Make this better
    return Future.error("Status code not 200");
  }

  var json = jsonDecode(response.body);

  List<Article> articles = [];
  Map<String?, String?> authors = {};
  Map<String?, String?> tags = {};

  for (var jsonArticle in json) {
    Article article;
    article = Article.fromJson(jsonArticle);
    article.source = url.host;

    if (!authors.containsKey(article.author)) {
      authors[article.author] = await getUser(website, int.tryParse(article.author!));
    }
    article.author = authors[article.author];

    var articleTags = List.from(article.categories);
    article.categories.clear();

    for(var tag in articleTags) {
      if (!tags.containsKey(tag)) {
        tags[tag] = await getTag(website, int.tryParse(tag));
      }

      article.categories.add(tags[tag]!);
    }

    articles.add(article);
  }

  return Future.value(articles);
}
