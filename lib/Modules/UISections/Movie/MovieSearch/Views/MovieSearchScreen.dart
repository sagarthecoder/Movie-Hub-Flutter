import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_hub/Modules/UISections/Movie/MovieDetails/ViewModel/MovieViewModel.dart';
import 'package:movie_hub/Modules/UISections/Movie/MovieSearch/Views/MovieSearchItemCell.dart';

class MovieSearchScreen extends StatelessWidget {
  MovieSearchScreen({super.key});

  TextEditingController searchController = TextEditingController();
  MovieViewModel viewModel = Get.find<MovieViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackgroundContainer(),
          _buildEmptyResult(),
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildEmptyResult() {
    return Obx(() {
      if (viewModel.searchMovieList.isEmpty) {
        return const Center(
          child: Text(
            'No items found',
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
        );
      } else {
        return Container();
      }
    });
  }

  Widget _buildBackgroundContainer() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.black, Colors.green],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      margin: const EdgeInsets.only(top: 50, left: 16, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Search',
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 20,
          ),
          _buildSearch(),
          SizedBox(
            height: 30,
          ),
          _showSearchResults(),
        ],
      ),
    );
  }

  Widget _buildSearch() {
    return Container(
      width: double.infinity,
      height: 44,
      child: SearchBar(
        controller: searchController,
        hintText: 'Search',
        leading: Icon(Icons.search),
        backgroundColor: WidgetStatePropertyAll(Colors.grey),
        onSubmitted: (outputText) {
          viewModel.searchMovie(outputText);
        },
      ),
    );
  }

  Widget _showSearchResults() {
    return Obx(() {
      return Expanded(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: viewModel.searchMovieList.map((item) {
              return Container(
                margin: EdgeInsets.only(bottom: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: MovieSearchItemCell(
                    movieInfo: item.obs,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      );
    });
  }
}
