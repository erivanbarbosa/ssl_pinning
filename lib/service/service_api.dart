import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:ssl_pinning/model/article.dart';
import 'package:ssl_pinning/model/news_response.dart';

abstract class ServiceApi {
  Future<List<Article>> fetchArticle();
}
