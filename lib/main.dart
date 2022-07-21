import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/repos/get_person_details_repo.dart';
import 'package:quiz/ui/screens/main_screen.dart';

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
      ],
      child: const MaterialApp(
        home: MainScreen(),
      ),
    );
  }
}
