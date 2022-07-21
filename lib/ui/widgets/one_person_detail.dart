import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../repos/person_details_repo.dart';
import 'loading_indicator.dart';

class OnePersonDetailWidget extends StatelessWidget {
  const OnePersonDetailWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, PersonDetailsRepo value, Widget? child) {
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
    );
  }
}
