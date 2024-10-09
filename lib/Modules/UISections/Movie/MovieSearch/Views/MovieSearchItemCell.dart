import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_hub/Config/MovieApiConfig.dart';
import 'package:movie_hub/Helpers/MathHelper.dart';
import 'package:movie_hub/Modules/UISections/CustomViews/NetworkImageView.dart';
import 'package:movie_hub/Modules/UISections/Movie/MovieDetails/Model/GenreInfo.dart';
import 'package:movie_hub/Modules/UISections/Movie/MovieDetails/ViewModel/MovieViewModel.dart';
import 'package:movie_hub/Modules/UISections/Movie/MovieDetails/Views/GenreListView.dart';
import 'package:movie_hub/Modules/UISections/Movie/MovieDetails/Views/MovieRatingSection.dart';
import 'package:movie_hub/Modules/UISections/Movie/MovieList/Model/MovieInfo.dart';

class MovieSearchItemCell extends StatelessWidget {
  final Rx<MovieInfo>? movieInfo;
  MovieSearchItemCell({this.movieInfo, super.key});
  MovieViewModel viewModel = Get.find<MovieViewModel>();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.grey.withOpacity(0.7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _showPoster(),
          Expanded(
            child: _showDescription(),
          ),
        ],
      ),
    );
  }

  Widget _showPoster() {
    String url =
        MovieApiConfig.posterBaseURL + (movieInfo?.value.posterPath ?? "");
    return Container(
      width: 140,
      height: 248,
      color: Colors.black,
      child: NetworkImageView(url: url),
    );
  }

  Widget _showDescription() {
    return Container(
      margin: EdgeInsets.only(top: 8, left: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _showGenres(),
          const SizedBox(
            height: 12,
          ),
          Text(
            movieInfo?.value.title ?? "",
            overflow: TextOverflow.visible,
            softWrap: true,
            maxLines: null,
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          Align(alignment: Alignment.bottomLeft, child: _showRating()),
        ],
      ),
    );
  }

  Widget _showGenres() {
    List<int> genreIds = movieInfo?.value.genreIds ?? [];
    List<GenreInfo> genres = [];
    genreIds.forEach((item) {
      String name = viewModel.getGenreName(item);
      genres.add(GenreInfo(id: item, name: name));
    });
    return Container(
      child: GenreListView(genres: genres),
    );
  }

  Widget _showRating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.star),
        const SizedBox(
          width: 10,
        ),
        Text(
          (movieInfo?.value.voteAverage ?? 0.0).toStringAsFixed(2),
          style: const TextStyle(
              fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
