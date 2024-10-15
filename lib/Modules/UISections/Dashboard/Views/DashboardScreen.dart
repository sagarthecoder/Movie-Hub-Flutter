import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_hub/Modules/UISections/CustomViews/FullScreenImagView.dart';
import 'package:movie_hub/Modules/UISections/Movie/MovieDetails/ViewModel/MovieViewModel.dart';
import 'package:movie_hub/Modules/UISections/Dashboard/Views/MovieViewer.dart';
import 'package:movie_hub/Modules/UISections/Movie/MovieDetails/Views/MovieDetailScreen.dart';

class DashboardScreen extends StatelessWidget {
  final MovieViewModel viewModel = Get.put(MovieViewModel());

  DashboardScreen({super.key}) {
    viewModel.fetchTopRatedMovies();
    viewModel.fetchUpcomingMovies();
    viewModel.fetchMovieDetails('278');
    viewModel.fetchFavoriteMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Stack(
        children: [
          FullScreenImageView(imagePath: "utils/images/blurry-background.png"),
          _displayOnScreenWidget(),
        ],
      ),
    );
  }

  Widget _displayOnScreenWidget() {
    return Container(
      margin: EdgeInsets.only(top: 60),
      height: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            _buildUserInfo(),
            _buildTopRatedMovies(),
            _buildUpcomingMovies(),
            _buildMyFavoriteMovies(),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfo() {
    return Container(
      margin: EdgeInsets.only(left: 16),
      child: const Align(
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              'Welcome back',
              style: TextStyle(fontSize: 9, color: Colors.white),
            ),
            Text(
              'Sagar Das',
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopRatedMovies() {
    return Obx(() {
      // This will rebuild when topRatedMovieList changes
      if (viewModel.topRatedMovieList.isNotEmpty) {
        return Container(
          margin: EdgeInsets.only(top: 30),
          child: MovieViewer(
            movieItemCallback: (item) {
              Get.to(() => MovieDetailScreen(movieInfo: item.obs));
            },
            title: "Top Rated Movies",
            movieItems: viewModel.topRatedMovieList,
          ),
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.pink,
          ),
        );
      }
    });
  }

  Widget _buildUpcomingMovies() {
    return Obx(() {
      // This will rebuild when topRatedMovieList changes
      if (viewModel.upcomingMovieList.isNotEmpty) {
        return Container(
          margin: EdgeInsets.only(top: 30),
          child: MovieViewer(
            movieItemCallback: (item) {
              Get.to(() => MovieDetailScreen(movieInfo: item.obs));
            },
            title: "Upcoming Movies",
            movieItems: viewModel.upcomingMovieList,
          ),
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.pink,
          ),
        );
      }
    });
  }

  Widget _buildMyFavoriteMovies() {
    return Obx(() {
      // This will rebuild when topRatedMovieList changes
      if (viewModel.favoriteMovieList.isNotEmpty) {
        return Container(
          margin: EdgeInsets.only(top: 30),
          child: MovieViewer(
            movieItemCallback: (item) {
              Get.to(() => MovieDetailScreen(movieInfo: item.obs));
            },
            title: "My favorites",
            movieItems: viewModel.favoriteMovieList,
          ),
        );
      } else {
        return Container();
      }
    });
  }
}
