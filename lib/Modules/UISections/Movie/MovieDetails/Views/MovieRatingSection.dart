import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:get/get.dart';
import 'package:movie_hub/Helpers/MathHelper.dart';

class MovieRatingSection extends StatelessWidget {
  final double overallRating;
  final double myRating;
  MovieRatingSection(
      {this.overallRating = 0.0, this.myRating = 0.0, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildRating(overallRating ?? 0.0, "Overall Rating"),
          const VerticalDivider(),
          _buildRating(myRating ?? 0.0, "My Rating")
        ],
      ),
    );
  }

  Widget _buildRating(double rating, String ratingTitle) {
    double mappedRating = MathHelper.mapValue(
        oldMin: 0, oldMax: 10, oldValue: rating, newMin: 0, newMax: 5);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          ratingTitle,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        Text(
          mappedRating.toStringAsFixed(2),
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        StarRating(
          starCount: 5,
          rating: mappedRating,
          filledIcon: Icons.star,
          halfFilledIcon: Icons.star_border,
          emptyIcon: Icons.star_border_sharp,
          color: Colors.pink, // Color for filled and half-filled icons
          borderColor:
              Colors.purpleAccent.withOpacity(0.4), // Color for empty icons
        )
      ],
    );
  }
}
