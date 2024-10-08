import 'package:get/get.dart';
import 'package:movie_hub/Config/MovieApiConfig.dart';
import 'package:movie_hub/Helpers/APIConstant.dart';
import 'package:movie_hub/Modules/Service/NetworkService/NetworkService.dart';
import 'package:movie_hub/Modules/UISections/Movie/MovieDetails/Model/MovieDetails.dart';

import '../../MovieList/Model/MovieInfo.dart';
import '../../MovieList/Model/MovieList.dart';

class MovieViewModel extends GetxController {
  var topRatedMovieList = <MovieInfo>[].obs;
  var upcomingMovieList = <MovieInfo>[].obs;
  Rx<MovieDetails?> movieDetails = MovieDetails().obs;
  void fetchTopRatedMovies() async {
    try {
      const url =
          '${APIConstant.baseURL}${APIConstant.topRatedMoviePath}?api_key=${MovieApiConfig.apiKey}';
      final output = await NetworkService.shared
          .genericApiRequest(url, RequestMethod.get, MovieList.fromJson);
      print('top rated output = ${output?.data?.first?.results?.length}');
      if (output == null) {
        return;
      }
      topRatedMovieList.value = output.data?.first.results ?? [];
    } catch (err) {
      print('Error = ${err.toString()}');
    }
  }

  void fetchUpcomingMovies() async {
    try {
      const url =
          '${APIConstant.baseURL}${APIConstant.upcomingMoviePath}?api_key=${MovieApiConfig.apiKey}';
      final output = await NetworkService.shared
          .genericApiRequest(url, RequestMethod.get, MovieList.fromJson);
      if (output == null) {
        return;
      }
      upcomingMovieList.value = output.data?.first.results ?? [];
    } catch (err) {
      print('Error = ${err.toString()}');
    }
  }

  void fetchMovieDetails(String? id) async {
    if (id == null) {
      return;
    }
    try {
      String url =
          '${APIConstant.baseURL}${APIConstant.movieDetails(id)}?api_key=${MovieApiConfig.apiKey}';
      final output = await NetworkService.shared
          .genericApiRequest(url, RequestMethod.get, MovieDetails.fromJson);
      if (output == null) {
        return;
      }
      movieDetails.value = output.data?.first;
    } catch (err) {
      print('fetchMovieDetails Error = ${err.toString()}');
    }
  }

  String formatRuntime(int? runtimeInMinutes) {
    if (runtimeInMinutes == null) {
      return "";
    }
    // Convert total runtime into hours, minutes, and seconds
    int hours = runtimeInMinutes ~/ 60; // Integer division to get hours
    int minutes = runtimeInMinutes % 60; // Get remainder minutes
    int seconds = 0; // Seconds not provided in the API

    // Return formatted string (optional: handle plural/singular)
    return '${hours}h ${minutes}m ${seconds}s';
  }
}
