import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_ware/http_service.dart';

import 'news_model.dart';

class NewsPage extends StatelessWidget {
  final HttpService httpService = HttpService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News"),
      ),
      body: FutureBuilder(
        future: httpService
            .getNews('https://newsapi.org/v2/top-headlines?country=in'),
        builder: (BuildContext context, AsyncSnapshot<List<News>> snapshot) {
          if (snapshot.hasData) {
            List<News> news = snapshot.data!;
            return ListView(
              children: news
                  .map(
                    (News n) => ListTile(
                      title: Text(n.title),
                      subtitle: Text(n.description),
                    ),
                  )
                  .toList(),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
