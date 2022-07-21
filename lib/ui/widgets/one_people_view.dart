import 'package:flutter/material.dart';
import 'package:quiz/models/global_variables.dart';
import 'package:quiz/models/popular_people.dart';

class OnePeopleView extends StatelessWidget {
  final PopularPeople onePopularPeople;
  const OnePeopleView({Key? key, required this.onePopularPeople})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.network(imageUrlBase + onePopularPeople.profilePath),
          Text(onePopularPeople.name),
        ],
      ),
    );
  }
}
