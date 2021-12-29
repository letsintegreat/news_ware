import 'dart:convert';
import 'dart:developer';
import 'secrets.dart';
import 'package:http/http.dart';
import 'news_model.dart';

class HttpService {
  Future<List<News>> getNews(String url) async {
    Response res = await get(Uri.parse(url + '&apiKey=' + Secret.apiKey));
    if (res.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(res.body);
      List<News> news = (body['articles'] as List)
          .map(
            (dynamic item) {
              News n = News.fromJson(item);
              return n;
            },
          )
          .toList();
      return news;
    } else {
      throw 'Error while fetching news at url: ' + url;
    }
  }
}
