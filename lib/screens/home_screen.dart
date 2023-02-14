import 'package:app_peliculas/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomeScreens extends StatelessWidget {
  const HomeScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Peliculas de cines'),
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.search_outlined))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // cardsSweiper
              CardSwiper(),
              // listado horixontal de peliculas
              MovieSlider(),
              MovieSlider(),
              MovieSlider(),
              MovieSlider(),
              MovieSlider()
            ],
          ),
        ));
  }
}
