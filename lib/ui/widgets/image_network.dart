import 'package:flutter/material.dart';

class ImageNetwrokWithErrorBuilder extends StatelessWidget {
  final String url;

  const ImageNetwrokWithErrorBuilder({Key? key, required this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      errorBuilder: (context, _, stack) {
        return Image.asset(
          'assets/no_photo.jpeg',
          fit: BoxFit.cover,
        );
      },
    );
  }
}
