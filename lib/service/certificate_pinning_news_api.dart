import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:ssl_pinning/model/article.dart';
import 'package:ssl_pinning/model/news_response.dart';
import 'package:ssl_pinning/service/service_api.dart';

class CertificatePinningNewApi extends ServiceApi {
  static const apiKey = "788576fa85e0490eacac2d580771d924";
  static const baseUrl = "https://newsapi.org/v2";
  static const baseUrl2 = "https://api.themoviedb.org/3";

  Future<List<Article>> fetchArticle() async {
    final uri = Uri.parse('$baseUrl/everything?q=flamengo&apiKey=788576fa85e0490eacac2d580771d924&language=pt');
    try {
      final client = await getSSLPinningClient();
      final response = await client.get(uri);
      if (response.statusCode == 200) {
        return NewsResponse.fromJson(json.decode(response.body)).articles;
      } else {
        throw Error();
      }
    } catch (error) {
      print(error);
      throw Error();
    }
  }

  Future<http.Client> getSSLPinningClient() async {
    HttpClient client = HttpClient(context: await globalContext);
    client.badCertificateCallback = (X509Certificate cert, String host, int port) {
      return false;
    };
    IOClient ioClient = IOClient(client);
    return ioClient;
  }

  Future<SecurityContext> get globalContext async {
    final sslCert = await rootBundle.load('assets/certificate.pem');
    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
    return securityContext;
  }
}
