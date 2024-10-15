import 'dart:convert';

import 'package:get/get.dart';
import 'package:movie_hub/Config/MovieApiConfig.dart';
import 'package:movie_hub/Helpers/APIConstant.dart';
import 'package:movie_hub/Modules/Service/AuthService/AuthService.dart';
import 'package:movie_hub/Modules/Service/NetworkService/NetworkService.dart';
import 'package:movie_hub/Modules/UISections/Movie/Favorites/Model/FavoriteRequest.dart';
import 'package:movie_hub/Modules/UISections/Movie/Favorites/Model/FavoriteResponse.dart';
import 'package:movie_hub/Modules/UISections/Movie/MovieDetails/Model/MovieDetails.dart';

import '../../MovieList/Model/MovieInfo.dart';
import '../../MovieList/Model/MovieList.dart';

class MovieViewModel extends GetxController {
  var topRatedMovieList = <MovieInfo>[].obs;
  var upcomingMovieList = <MovieInfo>[].obs;
  var searchMovieList = <MovieInfo>[].obs;
  var favoriteMovieList = <MovieInfo>[].obs;
  var isLoading = false.obs;
  Rx<MovieDetails?> movieDetails = MovieDetails().obs;
  Map<int, String> genreMap = {
    28: "Action",
    12: "Adventure",
    16: "Animation",
    35: "Comedy",
    80: "Crime",
    99: "Documentary",
    18: "Drama",
    10751: "Family",
    14: "Fantasy",
    36: "History",
    27: "Horror",
    10402: "Music",
    9648: "Mystery",
    10749: "Romance",
    878: "Science Fiction",
    10770: "TV Movie",
    53: "Thriller",
    10752: "War",
    37: "Western"
  };

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
      final items = output.data?.first.results;
      if (items != null) {
        topRatedMovieList.value = items;
      }
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
      final items = output.data?.first.results;
      if (items != null) {
        upcomingMovieList.value = items;
      }
    } catch (err) {
      print('Error = ${err.toString()}');
    }
  }

  void fetchFavoriteMovies() async {
    try {
      String url =
          '${APIConstant.baseURL}${APIConstant.getFavorites(MovieApiConfig.accountId)}?api_key=${MovieApiConfig.apiKey}&session_id=${MovieApiConfig.sessionId}';
      final output = await NetworkService.shared
          .genericApiRequest(url, RequestMethod.get, MovieList.fromJson);
      if (output == null) {
        return;
      }
      final items = output.data?.first.results;
      if (items != null) {
        favoriteMovieList.value = items;
      }
    } catch (err) {
      print('Error = ${err.toString()}');
    }
  }

  void searchMovie(String? query) async {
    if (query == null) {
      return;
    }
    try {
      String url =
          '${APIConstant.baseURL}${APIConstant.movieSearchPath}?query=${query}&api_key=${MovieApiConfig.apiKey}';
      final output = await NetworkService.shared
          .genericApiRequest(url, RequestMethod.get, MovieList.fromJson);
      if (output == null) {
        return;
      }
      final items = output.data?.first.results;
      if (items != null) {
        searchMovieList.value = items;
      }
    } catch (err) {
      print('Error on search API = ${err.toString()}');
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

    return '${hours}h ${minutes}m ${seconds}s';
  }

  String getGenreName(int genreID) {
    return genreMap[genreID] ?? "Unknown Genre";
  }

  void addToFavorite(FavoriteRequest request) async {
    isLoading.value = true;
    try {
      String url =
          '${APIConstant.baseURL}${APIConstant.addFavorites(MovieApiConfig.accountId)}?api_key=${MovieApiConfig.apiKey}&session_id=${MovieApiConfig.sessionId}';
      print("URL = ${url}");
      final body = jsonEncode(request.toJson());
      print("Body = ${body}");
      final response = await NetworkService.shared.genericApiRequest(
          url, RequestMethod.post, FavoriteResponse.fromJson,
          body: body);
      fetchFavoriteMovies();
    } catch (err) {
      print("Adding favorite Error = ${err.toString()}");
    }
    isLoading.value = false;
  }
}
