import 'package:flutter/material.dart';
import 'package:quiz/models/global_variables.dart';
import 'package:quiz/repos/save_image.dart';

import '../widgets/image_network.dart';

class OneImageView extends StatelessWidget {
  final String imageNPath;

  const OneImageView({Key? key, required this.imageNPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          saveNetworkImage(imageUrlBase + imageNPath).then((value) {
            if (value) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Photo saved successfully'),
              ));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('There was an error'),
              ));
            }
          });
        },
        child: const Icon(Icons.save),
      ),
      body: SafeArea(
        child: Hero(
          tag: imageNPath,
          child: ImageNetwrokWithErrorBuilder(url: imageNPath),
        ),
      ),
    );
  }
}
