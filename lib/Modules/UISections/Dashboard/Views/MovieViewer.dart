import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:movie_hub/Config/MovieApiConfig.dart';
import 'package:movie_hub/Modules/UISections/Dashboard/Model/MovieInfo.dart';
import 'package:movie_hub/Modules/UISections/Dashboard/ViewModel/MovieViewModel.dart';

class MovieViewer extends StatelessWidget {
  final String title;
  final RxList<MovieInfo> movieItems;
  MovieViewer({required this.title, RxList<MovieInfo>? movieItems, Key? key})
      : movieItems = movieItems ?? <MovieInfo>[].obs,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        const SizedBox(
          height: 16,
        ),
        _buildMovieList(),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 24,
      margin: const EdgeInsets.only(left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildMovieList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: movieItems.map((item) {
          return _buildMovieItem(item);
        }).toList(),
      ),
    );
  }

  Widget _buildMovieItem(MovieInfo item) {
    return Container(
      width: 150.0,
      height: 266.67,
      margin: EdgeInsets.only(left: 16, right: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          MovieApiConfig.posterBaseURL + (item.posterPath ?? ""),
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            // Handle image loading error
            return Container(
              color: Colors.grey,
              child: Center(
                child: Text('No image available',
                    style: TextStyle(color: Colors.white)),
              ),
            );
          },
        ),
      ),
    );
  }
}
