import 'package:advance/helpers/machines.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'construction/appPage.dart';
import 'construction/settingsMenuPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<Inventories>(
      create: (context) => Inventories(),
      child: MaterialApp(
        title: 'Advance: An Earth-Shattering Adventure',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          scaffoldBackgroundColor: Colors.black,
        ),
        home: const AppPage(),
        routes: {
          'menu': (context) => const SettingsMenuPage(),
          'settings': (context) => const SettingsMenuPage(),
        },
      ),
    );
  }
}
