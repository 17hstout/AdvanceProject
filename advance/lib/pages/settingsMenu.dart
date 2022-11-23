import 'package:advance/helpers/machines.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsMenu extends StatefulWidget {
  const SettingsMenu({super.key});

  @override
  State<SettingsMenu> createState() => _SettingsMenuState();
}

class _SettingsMenuState extends State<SettingsMenu> {
  Color saveStatus = Colors.purple;
  Color loadStatus = Colors.purple;
  Color resetStatus = Colors.purple;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Save Game Button
        TextButton.icon(
          onPressed: () async {
            int successCode =
                await Provider.of<Inventories>(context, listen: false)
                    .saveGame();
            setState(() {
              loadStatus = Colors.purple;
              resetStatus = Colors.purple;
              if (successCode == 0) {
                saveStatus = Colors.green;
              } else {
                saveStatus = Colors.red;
              }
            });
          },
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(saveStatus)),
          icon: const Icon(Icons.save_alt, color: Colors.white),
          label: const Text(
            "Save Game",
            style: TextStyle(color: Colors.white, fontSize: 32),
          ),
        ),
        // Spacer for safety
        const SizedBox(height: 32),

        // Save Game Button
        TextButton.icon(
          onPressed: () async {
            int successCode =
                await Provider.of<Inventories>(context, listen: false)
                    .loadGame();
            setState(() {
              saveStatus = Colors.purple;
              resetStatus = Colors.purple;
              if (successCode == 0) {
                loadStatus = Colors.green;
              } else {
                loadStatus = Colors.red;
              }
            });
          },
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(loadStatus)),
          icon: const Icon(Icons.upload, color: Colors.white),
          label: const Text(
            "Load Game",
            style: TextStyle(color: Colors.white, fontSize: 32),
          ),
        ),
        // Spacer for safety
        const SizedBox(height: 32),

        // Reset Game Button
        TextButton.icon(
          onPressed: () {
            int successCode =
                Provider.of<Inventories>(context, listen: false).newGame();
            setState(() {
              saveStatus = Colors.purple;
              loadStatus = Colors.purple;
              if (successCode == 0) {
                resetStatus = Colors.green;
              } else {
                resetStatus = Colors.red;
              }
            });
          },
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(resetStatus)),
          icon: const Icon(Icons.refresh, color: Colors.white),
          label: const Text(
            "Restart Game",
            style: TextStyle(color: Colors.white, fontSize: 32),
          ),
        ),
        // Spacer for safety
        const SizedBox(height: 32),

        // Close Menu Button
        TextButton.icon(
          onPressed: () {
            Navigator.of(context).popAndPushNamed('/');
          },
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(Colors.purple),
          ),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          label: const Text(
            "Close Settings Menu",
            style: TextStyle(color: Colors.white, fontSize: 32),
          ),
        ),
      ],
    );
  }
}
