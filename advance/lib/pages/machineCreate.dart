import 'package:advance/helpers/machines.dart';
import 'package:flutter/material.dart';

class MachineCreate extends StatelessWidget {
  const MachineCreate({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.teal,
      child: Column(
        children: [
          const Text(
            'What machines exist?',
          ),
          ...[
            for (String machine in MachineHelper.machines.keys) Text(machine)
          ],
        ],
      ),
    );
  }
}
