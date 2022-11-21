import 'package:advance/helpers/machines.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MachineList extends StatelessWidget {
  const MachineList({super.key});

  @override
  Widget build(BuildContext context) {
    MachineInventory thisFloor;
    // Floor 0 is hard coded until other floors exist
    try {
      thisFloor = Provider.of<Inventories>(context, listen: false).inv[0];
    } catch (e) {
      Provider.of<Inventories>(context, listen: false).newGame();
      thisFloor = Provider.of<Inventories>(context, listen: false).inv[0];
    }
    return ListView.builder(
      shrinkWrap: true,
      itemCount: thisFloor.machines.length + 1,
      itemBuilder: (context, index) {
        MachineObj thisMachine;
        try {
          thisMachine = thisFloor.machines[index - 1];
        } on RangeError catch (e) {
          return const Card(
            color: Colors.yellow,
            child: Text(
              "Here are your machines:",
              textAlign: TextAlign.center,
            ),
          );
        }
        return Card(
          child: Column(
            children: [
              Text(
                thisMachine.info(),
                textAlign: TextAlign.center,
              ),
              TextButton(
                onPressed: () {
                  print("booped ${thisMachine.id}");
                },
                child: const Text("Do Nothing"),
              ),
            ],
          ),
        );
      },
    );
  }
}
