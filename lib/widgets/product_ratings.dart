import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductRatings extends StatelessWidget {
  final double itemSize, initialRating;
  final bool ignoreGesture;
  const ProductRatings({
    Key? key,
    this.initialRating = 0.0,
    this.itemSize = 40.0,
    this.ignoreGesture = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBar(
      ignoreGestures: ignoreGesture,
      itemSize: itemSize,
      onRatingUpdate: (value) {},
      allowHalfRating: true,
      itemCount: 5,
      initialRating: initialRating,
      ratingWidget: RatingWidget(
        full: const Icon(
          Icons.star_rounded,
          color: Colors.amber,
          size: 15,
        ),
        half: const Icon(
          Icons.star_rounded,
          color: Colors.amber,
          size: 15,
        ),
        empty: const Icon(
          Icons.star_border_rounded,
          color: Colors.amber,
          size: 15,
        ),
      ),
    );
  }
}
