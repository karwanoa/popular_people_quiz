import 'dart:io';

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
    checkUserConnectionAndFecth();

    _scrollController = ScrollController();
  }

  checkUserConnectionAndFecth() async {
    //Check connection to google.com to determine if there is internet connection to internet or not
    //and display the result live or from cache based on the result
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        //Load first page of popular people
        Provider.of<PopularPeopeleRepo>(context, listen: false)
            .getPopularPeople();
      }
    } on SocketException catch (_) {
      Provider.of<PopularPeopeleRepo>(context, listen: false)
          .getPopularPeopleFromCache();
    }
  }

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      // nextPageTrigger will have a value equivalent to 80% of the list size.
      var nextPageTrigger = 0.8 * _scrollController.position.maxScrollExtent;

      // _scrollController fetches the next paginated data when the current postion of the user on the screen has surpassed
      if (_scrollController.position.pixels > nextPageTrigger) {
        //will not ask for more entries if the repo is already in loading state or it is fetched items from cache
        if (Provider.of<PopularPeopeleRepo>(context, listen: false)
                    .popularPeopeleStatus !=
                PopularPeopeleStatus.Loading &&
            Provider.of<PopularPeopeleRepo>(context, listen: false)
                    .popularPeopeleStatus !=
                PopularPeopeleStatus.FromCache) {
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
                case PopularPeopeleStatus.FromCache:
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
                        isTappable: Provider.of<PopularPeopeleRepo>(context,
                                        listen: false)
                                    .popularPeopeleStatus ==
                                PopularPeopeleStatus.FromCache
                            ? false
                            : true,
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
