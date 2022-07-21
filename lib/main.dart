import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:provider/provider.dart';
import 'package:quiz/repos/person_details_repo.dart';
import 'package:quiz/ui/screens/main_screen.dart';

import 'models/popular_people.dart';
import 'repos/person_images_repo.dart';
import 'repos/popular_people_repo.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  // Hive.registerAdapter(OnePersonDetailsAdapter());
  Hive.registerAdapter(PopularPeopleAdapter());
  // await Hive.openBox<OnePersonDetails>('one_person');
  await Hive.openBox<PopularPeople>('popular_people');

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
