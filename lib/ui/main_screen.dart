import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/global_variables.dart';
import '../repos/answered_sruvey.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular People'),
      ),
      body: ListView(
        children: [
          OutlinedButton(
            onPressed: () {
              Provider.of<PopularPeopeleRepo>(context, listen: false)
                  .getAllSurveys();
            },
            child: const Text('Call'),
          ),
          Consumer(
            builder: (BuildContext context, PopularPeopeleRepo value,
                Widget? child) {
              switch (value.popularPeopeleStatus) {
                case PopularPeopeleStatus.Unloaded:
                case PopularPeopeleStatus.Loading:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case PopularPeopeleStatus.Loaded:
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: value.popularPeople.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: Column(
                          children: [
                            Image.network(imageUrlBase +
                                value.popularPeople[index].profilePath),
                            Text(value.popularPeople[index].name),
                          ],
                        ),
                      );
                    },
                  );

                default:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
              }
            },
          ),
        ],
      ),
    );
  }
}
