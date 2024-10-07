import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_hub/Modules/UISections/Dashboard/ViewModel/MovieViewModel.dart';
import 'package:movie_hub/Modules/UISections/Dashboard/Views/MovieViewer.dart';

class DashboardScreen extends StatelessWidget {
  final MovieViewModel viewModel = Get.put(MovieViewModel());

  DashboardScreen({super.key}) {
    viewModel.fetchTopRatedMovies();
    viewModel.fetchUpcomingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Container(
        margin: EdgeInsets.only(top: 60),
        height: double.infinity,
        child: Column(
          children: [
            Obx(() {
              // This will rebuild when topRatedMovieList changes
              if (viewModel.topRatedMovieList.isNotEmpty) {
                return MovieViewer(
                  title: "Top Rated Movies",
                  movieItems: viewModel.topRatedMovieList,
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.pink,
                  ),
                );
              }
            }),
            SizedBox(height: 10),
            Obx(() {
              // This will rebuild when topRatedMovieList changes
              if (viewModel.topRatedMovieList.isNotEmpty) {
                return MovieViewer(
                  title: "Upcoming Movies",
                  movieItems: viewModel.upcomingMovieList,
                );
              } else {
                return Container();
              }
            }),
          ],
        ),
      ),
    );
  }
}
