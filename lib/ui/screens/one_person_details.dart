import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/models/global_variables.dart';
import 'package:quiz/models/popular_people.dart';
import 'package:quiz/repos/get_person_details_repo.dart';
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
                url: imageUrlBase + widget.onePopularPeople.profilePath),
          ),
          Consumer(
            builder:
                (BuildContext context, PersonDetailsRepo value, Widget? child) {
              switch (value.personDetailsStatus) {
                case PersonDetailsStatus.Unloaded:
                  return const LoadingIndicator();
                case PersonDetailsStatus.Loaded:
                case PersonDetailsStatus.Loading:
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
        ],
      ),
    );
  }
}
