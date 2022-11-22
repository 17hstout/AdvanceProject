import 'package:advance/helpers/machines.dart';
import 'package:advance/pages/explore.dart';
import 'package:advance/pages/machineCreate.dart';
import 'package:advance/pages/machineList.dart';
import 'package:advance/pages/settingsMenu.dart';
import 'package:advance/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        initialRoute: '/',
        routes: {
          '/': (context) => const AppPage(),
          '/home': (context) => const AppPage(),
          '/play': (context) => const AppPage(),
          '/main': (context) => const AppPage(),
          '/menu': (context) => const SettingsMenuPage(),
          '/settings': (context) => const SettingsMenuPage(),
        },
      ),
    );
  }
}

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  int bottomNavLocation = 1;
  List<Widget> pageFromNavId = [
    const MachineCreate(), //build
    const MachineList(), //machines
    const Explore(), //explore
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Your Currency: ???'),
          actions: [
            IconButton(
              icon: Settings.menuIcon,
              onPressed: () => Navigator.pushNamed(context, 'settings'),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.teal,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          unselectedItemColor: Colors.grey,
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          currentIndex: bottomNavLocation,
          onTap: (newIndex) {
            setState(() {
              bottomNavLocation = newIndex;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Settings.buildIcon,
              label: "Build",
            ),
            BottomNavigationBarItem(
              icon: Settings.machineIcon,
              label: "Machines",
            ),
            BottomNavigationBarItem(
              icon: Settings.exploreIcon,
              label: "Explore",
            ),
          ],
        ),
        body: Center(
          child: pageFromNavId[bottomNavLocation],
        ),
      ),
    );
  }
}

class SettingsMenuPage extends StatelessWidget {
  const SettingsMenuPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Advance'),
        ),
        body: const Center(child: SettingsMenu()),
      ),
    );
  }
}
