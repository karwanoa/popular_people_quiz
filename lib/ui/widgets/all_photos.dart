import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:quiz/ui/screens/one_image_view.dart';

import '../../repos/person_images_repo.dart';
import 'image_network.dart';
import 'loading_indicator.dart';

class AllPhotos extends StatelessWidget {
  const AllPhotos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, PersonImagesRepo value, Widget? child) {
        switch (value.personImagesStatus) {
          case PersonImagesStatus.Loading:
          case PersonImagesStatus.Unloaded:
            return const LoadingIndicator();
          case PersonImagesStatus.Loaded:
            return MasonryGridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              itemCount: value.onePersonImages.length,
              itemBuilder: (context, index) {
                return value.onePersonImages[index].filePath.isEmpty
                    ? Container()
                    : GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return OneImageView(
                              imageNPath: value.onePersonImages[index].filePath,
                            );
                          }));
                        },
                        child: Hero(
                          tag: value.onePersonImages[index].filePath,
                          child: ImageNetwrokWithErrorBuilder(
                            url: value.onePersonImages[index].filePath,
                          ),
                        ),
                      );
              },
            );
          default:
            return const LoadingIndicator();
        }
      },
    );
  }
}
