import 'package:flutter/material.dart';
import 'package:quiz/models/global_variables.dart';
import 'package:quiz/models/popular_people.dart';
import 'package:quiz/ui/screens/one_person_details.dart';
import 'package:quiz/ui/widgets/image_network.dart';

class OnePeopleView extends StatelessWidget {
  final PopularPeople onePopularPeople;
  const OnePeopleView({Key? key, required this.onePopularPeople})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return OnePersonDetails(onePopularPeople: onePopularPeople);
        }));
      },
      child: Card(
        elevation: 4,
        child: Column(
          children: [
            Expanded(
              child: Hero(
                tag: onePopularPeople.id,
                child: ImageNetwrokWithErrorBuilder(
                    url: onePopularPeople.profilePath),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(onePopularPeople.name),
            ),
          ],
        ),
      ),
    );
  }
}
