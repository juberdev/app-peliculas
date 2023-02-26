// import 'dart:convert';
import 'dart:async';

import 'package:app_peliculas/helpers/debouncer.dart';
import 'package:app_peliculas/models/model.dart';
import 'package:app_peliculas/models/search_movies_response.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier {
  final String _apiKey = 'f1aa00fb42d694e08551b56405a516f4';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-Es';

  List<Movie> onDisplayMovies = [];
  List<Movie> onPopularMovies = [];

  Map<int, List<Cast>> moviesCast = {};

  int _popularPage = 0;

  final debouncer = Debouncer(duration: Duration(milliseconds: 500));

  final StreamController<List<Movie>> _streamController =
      StreamController.broadcast();

  Stream<List<Movie>> get seggestionstream => this._streamController.stream;

  MoviesProvider() {
    // print('movies provider inicializado');
    getOndisplayMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData(String endPoitn, [int page = 1]) async {
    final url = Uri.https(_baseUrl, endPoitn, {
      'api_key': _apiKey,
      'language': _language,
      'page': '$page',
    });
    final response = await http.get(url);
    return response.body;
  }

  getOndisplayMovies() async {
    final response = await _getJsonData('3/movie/now_playing');

    final dataPlayin = NowPlayingResponse.fromRawJson(response);
    onDisplayMovies = dataPlayin.results;

    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;
    final response = await _getJsonData('3/movie/popular', _popularPage);

    final popularResponse = PopularResponse.fromRawJson(response);

    onPopularMovies = [...onPopularMovies, ...popularResponse.results];

    notifyListeners();
  }

  Future<List<Cast>> getMoveisCast(int movieId) async {
    if (moviesCast.containsKey(movieId)) return moviesCast[movieId]!;
    final response = await _getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromRawJson(response);
    moviesCast[movieId] = creditsResponse.cast;
    return creditsResponse.cast;
  }

  Future<List<Movie>> searchMovies(String query) async {
    final url = Uri.https(_baseUrl, '3/search/movie', {
      'api_key': _apiKey,
      'language': _language,
      'query': query,
    });
    final response = await http.get(url);
    final result = SearchResponse.fromRawJson(response.body);
    return result.results;
  }

  void getSuggestionByQuery(String searchTerm) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final result = await searchMovies(value);
      _streamController.add(result);
    };

    final timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      debouncer.value = searchTerm;
    });

    Future.delayed(const Duration(milliseconds: 301))
        .then((value) => timer.cancel());
  }
}
