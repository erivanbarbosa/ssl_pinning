import 'package:flutter/material.dart';
import 'package:ssl_pinning/pages/certificate_pinning_page.dart';
import 'package:ssl_pinning/pages/no_pinning_page.dart';
import 'package:ssl_pinning/service/certificate_pinning_news_api.dart';
import 'package:ssl_pinning/service/no_pinning_news_api.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final certificatePinningNewApi = CertificatePinningNewApi();
  final noPinningNewApi = NoPinningNewsApi();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SLL PINNING TEST',
      home: DefaultTabController(
        length: 2, // Number of tabs
        child: Scaffold(
          appBar: AppBar(
            title: const Text('SLL PINNING TEST'),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Certificate Pinning'),
                Tab(text: 'No pinning'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              CertificatePinningPage(apiService: certificatePinningNewApi),
              CertificatePinningPage(apiService: noPinningNewApi),
            ],
          ),
        ),
      ),
    );
  }
}