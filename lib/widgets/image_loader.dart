import 'package:flutter/material.dart';
class ImageLoader extends StatelessWidget {
  final String imageUrl;
  const ImageLoader({Key? key,required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      fit: BoxFit.cover,
      imageUrl,
      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
        return Image.asset(
          'assets/images/dumy.png',
          fit: BoxFit.cover,
        );
      },
    );
  }
}
