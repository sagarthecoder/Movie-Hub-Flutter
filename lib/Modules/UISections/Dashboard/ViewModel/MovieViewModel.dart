import 'package:get/get.dart';
import 'package:movie_hub/Config/MovieApiConfig.dart';
import 'package:movie_hub/Helpers/APIConstant.dart';
import 'package:movie_hub/Modules/Service/NetworkService/NetworkService.dart';
import 'package:movie_hub/Modules/UISections/Dashboard/Model/MovieList.dart';

import '../Model/MovieInfo.dart';

class MovieViewModel extends GetxController {
  var topRatedMovieList = <MovieInfo>[].obs;
  var upcomingMovieList = <MovieInfo>[].obs;

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
}
