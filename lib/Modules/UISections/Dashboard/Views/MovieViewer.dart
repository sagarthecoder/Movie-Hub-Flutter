import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_hub/Config/MovieApiConfig.dart';
import 'package:movie_hub/Modules/UISections/CustomViews/NetworkImageView.dart';
import 'package:movie_hub/Modules/UISections/Movie/MovieList/Model/MovieInfo.dart';

class MovieViewer extends StatelessWidget {
  final String title;
  final RxList<MovieInfo> movieItems;
  final Function(MovieInfo movieInfo)? movieItemCallback;

  MovieViewer({
    required this.title,
    RxList<MovieInfo>? movieItems,
    this.movieItemCallback,
    Key? key,
  })  : movieItems = movieItems ?? <MovieInfo>[].obs,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _buildHeader(context),
          const SizedBox(
            height: 16,
          ),
          _buildMovieList(),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 24,
      margin: const EdgeInsets.only(left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color:
                  Theme.of(context).textTheme.titleLarge?.color ?? Colors.white,
            ),
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
        children: List.generate(movieItems.length, (index) {
          final item = movieItems[index];
          return _buildMovieItem(item);
        }),
      ),
    );
  }

  Widget _buildMovieItem(MovieInfo item) {
    String url = MovieApiConfig.posterBaseURL + (item.posterPath ?? "");
    return GestureDetector(
      onTap: () {
        movieItemCallback?.call(item);
      },
      child: Container(
        width: 150.0,
        height: 266.67,
        margin: const EdgeInsets.only(left: 16, right: 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: NetworkImageView(url: url),
        ),
      ),
    );
  }
}
