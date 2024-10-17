import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_hub/Modules/UISections/Movie/MovieDetails/ViewModel/MovieViewModel.dart';
import 'package:movie_hub/Modules/UISections/Movie/MovieSearch/Views/MovieSearchItemCell.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MovieSearchScreen extends StatelessWidget {
  MovieSearchScreen({super.key});

  TextEditingController searchController = TextEditingController();
  MovieViewModel viewModel = Get.find<MovieViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackgroundContainer(context),
          _buildEmptyResult(context),
          _buildContent(context),
        ],
      ),
    );
  }

  Widget _buildEmptyResult(BuildContext context) {
    return Obx(() {
      if (viewModel.searchMovieList.isEmpty) {
        return Center(
          child: Text(
            AppLocalizations.of(context)!.no_items_found,
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
        );
      } else {
        return Container();
      }
    });
  }

  Widget _buildBackgroundContainer(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.background,
            Theme.of(context).colorScheme.primary,
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50, left: 16, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.search_tab_text,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          _buildSearch(context),
          const SizedBox(height: 30),
          _showSearchResults(),
        ],
      ),
    );
  }

  Widget _buildSearch(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 44,
      child: SearchBar(
        controller: searchController,
        hintText: AppLocalizations.of(context)!.search_tab_text,
        leading:
            Icon(Icons.search, color: Theme.of(context).colorScheme.onSurface),
        backgroundColor:
            MaterialStateProperty.all(Theme.of(context).colorScheme.surface),
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
                margin: const EdgeInsets.only(bottom: 10),
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
