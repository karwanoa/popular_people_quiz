import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:quiz/models/global_variables.dart';
import 'package:quiz/models/popular_people.dart';
import 'package:quiz/repos/person_details_repo.dart';
import 'package:quiz/repos/person_images_repo.dart';
import 'package:quiz/ui/widgets/image_network.dart';

import '../widgets/loading_indicator.dart';

class OnePersonDetails extends StatefulWidget {
  final PopularPeople onePopularPeople;

  const OnePersonDetails({Key? key, required this.onePopularPeople})
      : super(key: key);

  @override
  State<OnePersonDetails> createState() => _OnePersonDetailsState();
}

class _OnePersonDetailsState extends State<OnePersonDetails> {
  @override
  void initState() {
    super.initState();
    Provider.of<PersonDetailsRepo>(context, listen: false)
        .getPopularPeople(widget.onePopularPeople.id);
    Provider.of<PersonImagesRepo>(context, listen: false)
        .getImages(widget.onePopularPeople.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.onePopularPeople.name),
      ),
      body: ListView(
        children: [
          Hero(
            tag: widget.onePopularPeople.id,
            child: ImageNetwrokWithErrorBuilder(
                url: widget.onePopularPeople.profilePath),
          ),
          Consumer(
            builder:
                (BuildContext context, PersonDetailsRepo value, Widget? child) {
              switch (value.personDetailsStatus) {
                case PersonDetailsStatus.Loading:
                case PersonDetailsStatus.Unloaded:
                  return const LoadingIndicator();
                case PersonDetailsStatus.Loaded:
                  return Column(
                    children: [
                      ListTile(
                        title: Text(
                          'Birthday: ${value.onePersonDetails!.birthday}',
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Place of Birth: ${value.onePersonDetails!.placeOfBirth}',
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Department: ${value.onePersonDetails!.knownForDepartment}',
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Biography: ${value.onePersonDetails!.biography}',
                        ),
                      ),
                    ],
                  );

                default:
                  return const LoadingIndicator();
              }
            },
          ),
          Consumer(
            builder:
                (BuildContext context, PersonImagesRepo value, Widget? child) {
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
                      debugPrint(
                          'index $index = ${value.onePersonImages[index].filePath}');
                      return value.onePersonImages[index].filePath == ''
                          ? Container()
                          : ImageNetwrokWithErrorBuilder(
                              url: value.onePersonImages[index].filePath,
                            );
                    },
                  );
                default:
                  return const LoadingIndicator();
              }
            },
          ),
        ],
      ),
    );
  }
}
