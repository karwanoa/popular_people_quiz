import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/models/popular_people.dart';
import 'package:quiz/repos/person_details_repo.dart';
import 'package:quiz/repos/person_images_repo.dart';
import 'package:quiz/ui/widgets/image_network.dart';

import '../widgets/all_photos.dart';
import '../widgets/one_person_detail.dart';

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
          const OnePersonDetailWidget(),
          const AllPhotos(),
        ],
      ),
    );
  }
}
