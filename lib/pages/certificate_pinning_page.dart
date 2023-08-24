import 'package:flutter/material.dart';
import 'package:ssl_pinning/model/article.dart';
import 'package:ssl_pinning/service/certificate_pinning_news_api.dart';
import 'package:ssl_pinning/service/service_api.dart';

class CertificatePinningPage extends StatelessWidget {
  final ServiceApi apiService;
  const CertificatePinningPage({required this.apiService});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Article>>(
      future: apiService.fetchArticle(),
      builder:
              (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
            if (snapshot.data != null) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final article = snapshot.data![index];
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            article.title,
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                          Text(article.description),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: snapshot.data?.length,
              );
            } else {
              return Center(
                child: Column(
                  children: const [
                    CircularProgressIndicator(),
                    Text("Load data, please wait...")
                  ],
                ),
              );
            }
          },
    );
  }
}
