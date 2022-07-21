import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/repos/person_details_repo.dart';
import 'package:quiz/ui/screens/main_screen.dart';

import 'repos/person_images_repo.dart';
import 'repos/popular_people_repo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PopularPeopeleRepo(),
        ),
        ChangeNotifierProvider(
          create: (context) => PersonDetailsRepo(),
        ),
        ChangeNotifierProvider(
          create: (context) => PersonImagesRepo(),
        ),
      ],
      child: const MaterialApp(
        home: MainScreen(),
      ),
    );
  }
}
