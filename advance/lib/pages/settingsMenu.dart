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
      child: Column(
        children: [
          TextButton.icon(
            onPressed: () {
              int success =
                  Provider.of<Inventories>(context, listen: false).newGame();
              setState(() {
                if (success != 0) {
                  myColor = Colors.red;
                } else {
                  myColor = Colors.green;
                }
              });
            },
            icon: const Icon(Icons.undo, color: Colors.white),
            label: const Text(
              "Restart Game",
              style: TextStyle(color: Colors.white),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              print("Settings");
            },
          ),
        ],
      ),
    );
  }
}
