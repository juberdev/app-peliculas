import 'package:app_peliculas/providers/movies_provider.dart';
import 'package:app_peliculas/search/search_delegate.dart';
import 'package:app_peliculas/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreens extends StatelessWidget {
  const HomeScreens({super.key});

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: true);
    // final moviesPopulares = Provider.of<MoviesProvider>(context, listen: true);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Peliculas de cines'),
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () => showSearch(
                context: context,
                delegate: MovieSearchDelegate(),
              ),
              icon: const Icon(Icons.search_outlined),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // cardsSweiper
              CardSwiper(
                movies: moviesProvider.onDisplayMovies,
              ),
              // listado horixontal de peliculas
              MovieSlider(
                movies: moviesProvider.onPopularMovies,
                title: 'pupulares xd',
                onNextPage: () => moviesProvider.getPopularMovies(),
              ),
              // MovieSlider(),
              // MovieSlider(),
              // MovieSlider(),
              // MovieSlider()
            ],
          ),
        ));
  }
}
