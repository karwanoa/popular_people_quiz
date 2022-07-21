import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:quiz/models/global_variables.dart';

class ImageNetwrokWithErrorBuilder extends StatelessWidget {
  final String url;

  const ImageNetwrokWithErrorBuilder({Key? key, required this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrlBase + url,
      fit: BoxFit.cover,
      errorWidget: (context, _, stack) {
        return Image.asset(
          'assets/no_photo.jpeg',
          fit: BoxFit.cover,
        );
      },
    );
  }
}
