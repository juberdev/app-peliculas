import 'dart:convert';

import 'package:app_peliculas/models/model.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier {
  final String _apiKey = 'f1aa00fb42d694e08551b56405a516f4';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-Es';
  MoviesProvider() {
    print('movies provider inicializado');
    getOndisplayMovies();
  }

  getOndisplayMovies() async {
    // https://developers.google.com/books/docs/overview
    var url = Uri.https(_baseUrl, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language, 'page': '1'});

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);

    final dataPlayin = NowPlayingResponse.fromRawJson(response.body);
    // final Map<String, dynamic> decodeData = json.decode(response.body);
    print(dataPlayin.results[0].title);
  }
}
