import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_hub/Modules/UISections/Movie/MovieDetails/Model/GenreInfo.dart';

class GenreListView extends StatelessWidget {
  final List<GenreInfo> genres;
  GenreListView({required this.genres, super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: genres.map((item) {
            return Text(
              "${item.name ?? ""} . ",
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4),
            );
          }).toList(),
        ));
  }
}
