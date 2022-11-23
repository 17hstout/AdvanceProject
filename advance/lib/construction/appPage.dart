import 'package:flutter/material.dart';
import 'package:advance/pages/explore.dart';
import 'package:advance/pages/machineCreate.dart';
import 'package:advance/pages/machineList.dart';
import 'package:advance/settings.dart';
import 'appBar.dart';

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
          title: const TopBar(),
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
