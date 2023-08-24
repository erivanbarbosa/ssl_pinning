import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ssl_pinning/model/article.dart';
import 'package:ssl_pinning/model/news_response.dart';
import 'package:ssl_pinning/service/service_api.dart';

class NoPinningNewsApi extends ServiceApi {
  final http.Client client = http.Client();
  static const baseUrl = "https://newsapi.org/v2";
  static const baseUrl2 = "https://api.themoviedb.org/3";

  Future<List<Article>> fetchArticle() async {
    final uri = Uri.parse('$baseUrl/everything?q=flutter&apiKey=788576fa85e0490eacac2d580771d924');
      final response = await client.get(uri);
      if (response.statusCode == 200) {
        return NewsResponse.fromJson(json.decode(response.body)).articles;
      } else {
        throw Error();
      }
  }
}
