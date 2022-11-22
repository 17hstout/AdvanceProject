import 'package:advance/helpers/machines.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsMenu extends StatefulWidget {
  const SettingsMenu({super.key});

  @override
  State<SettingsMenu> createState() => _SettingsMenuState();
}

class _SettingsMenuState extends State<SettingsMenu> {
  Color myColor = Colors.purple;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: myColor,
      child: TextButton.icon(
        onPressed: () {
          int successCode =
              Provider.of<Inventories>(context, listen: false).newGame();
          setState(() {
            if (successCode == 0) {
              myColor = Colors.green;
            } else {
              myColor = Colors.red;
            }
          });
        },
        icon: const Icon(Icons.refresh, color: Colors.white),
        label: const Text(
          "Restart Game",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
