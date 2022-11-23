import 'package:advance/settings.dart';
import 'package:flutter/material.dart';

class Explore extends StatelessWidget {
  const Explore({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      child: IconButton(
        icon: Settings.exploreIcon,
        onPressed: () {
          print("woooo adventure");
        },
      ),
    );
  }
}
