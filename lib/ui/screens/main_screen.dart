import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/ui/widgets/one_people_view.dart';

import '../../repos/popular_people_repo.dart';
import '../widgets/loading_indicator.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    //Load first page of popular people
    Provider.of<PopularPeopeleRepo>(context, listen: false).getPopularPeople();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      // nextPageTrigger will have a value equivalent to 80% of the list size.
      var nextPageTrigger = 0.8 * _scrollController.position.maxScrollExtent;

      // _scrollController fetches the next paginated data when the current postion of the user on the screen has surpassed
      if (_scrollController.position.pixels > nextPageTrigger) {
        if (Provider.of<PopularPeopeleRepo>(context, listen: false)
                .popularPeopeleStatus !=
            PopularPeopeleStatus.Loading) {
          Provider.of<PopularPeopeleRepo>(context, listen: false)
              .getPopularPeople();
        }
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular People'),
      ),
      body: ListView(
        controller: _scrollController,
        children: [
          Consumer(
            builder: (BuildContext context, PopularPeopeleRepo value,
                Widget? child) {
              switch (value.popularPeopeleStatus) {
                case PopularPeopeleStatus.Unloaded:
                  return const LoadingIndicator();
                case PopularPeopeleStatus.Loaded:
                case PopularPeopeleStatus.Loading:
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 2,
                      childAspectRatio: 9 / 16,
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: value.popularPeople.length,
                    itemBuilder: (BuildContext context, int index) {
                      return OnePeopleView(
                        onePopularPeople: value.popularPeople[index],
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
