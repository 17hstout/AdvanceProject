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
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          scaffoldBackgroundColor: Colors.black,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int bottomNavLocation = 1;
  List<Widget> pageFromNavId = [
    const MachineCreate(), //build
    const MachineList(), //machines
    const Explore(), //explore
    const SettingsMenu(), //settings
  ];

  @override
  Widget build(BuildContext context) {
    // Start fresh on each load (for now)
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Advance'),
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
            BottomNavigationBarItem(
              icon: Settings.menuIcon,
              label: "Menu",
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
