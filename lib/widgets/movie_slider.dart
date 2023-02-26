import 'package:app_peliculas/models/model.dart';
import 'package:flutter/material.dart';

class MovieSlider extends StatefulWidget {
  // const MovieSlider({super.key});
  final List<Movie> movies;
  final String? title;
  final Function onNextPage;

  const MovieSlider({
    super.key,
    required this.movies,
    this.title,
    required this.onNextPage,
  });

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  final _scrollControllerx = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollControllerx.addListener(() {
      if (_scrollControllerx.position.pixels >=
          _scrollControllerx.position.maxScrollExtent - 500) {
        widget.onNextPage();
      }
      // print(_scrollControllerx.position.pixels);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 260,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Text(
                widget.title!,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          const SizedBox(height: 2),
          Expanded(
            child: ListView.builder(
              controller: _scrollControllerx,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder: (_, int index) =>
                  _MoviePoster(movie: widget.movies[index]),
            ),
          ),
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  // const _MoviePoster({super.key});
  final Movie movie;
  const _MoviePoster({super.key, required this.movie});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              'details',
              arguments: movie,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fullPosterImg),
                width: 130,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            movie.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 10),
          ),
        ],
      ),
    );
  }
}
