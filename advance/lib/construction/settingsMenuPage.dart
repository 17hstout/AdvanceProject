import 'package:advance/pages/settingsMenu.dart';
import 'package:flutter/material.dart';

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
