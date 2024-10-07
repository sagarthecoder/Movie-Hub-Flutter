import 'package:cached_network_image/cached_network_image.dart';
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
    return Container(
      child: Column(
        children: [
          _buildHeader(),
          const SizedBox(
            height: 16,
          ),
          _buildMovieList(),
        ],
      ),
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
    String url = MovieApiConfig.posterBaseURL + (item.posterPath ?? "");
    return Container(
      width: 150.0,
      height: 266.67,
      margin: const EdgeInsets.only(left: 16, right: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: CachedNetworkImage(
          imageUrl: url,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
