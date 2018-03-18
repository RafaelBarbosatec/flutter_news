import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsApi{

  final String apiKey = '448b663c578f4c70846d2e9875b4be5e';
  final String url = 'https://newsapi.org/v2/top-headlines';

  Future <Map> loadNews(String country, String category) async{

    String apiUrl = '$url?country=$country&category=$category&apiKey=$apiKey';
    // Make a HTTP GET request to the CoinMarketCap API.
    // Await basically pauses execution until the get() function returns a Response
    http.Response response = await http.get(apiUrl);
    // Using the JSON class to decode the JSON String
    return JSON.decode(response.body);

  }
}