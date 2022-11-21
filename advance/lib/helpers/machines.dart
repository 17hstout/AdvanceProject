class MachineHelper {
  static Map<String, Map<String, dynamic>> machines = {
    "Slow Miner": {
      "category": "automated",
      "cost": {"dollars": 100}, // Cost is for initial purchase + each upgrade
      "gets": {"stone", "quartz"},
      "mats_per_collection": 1,
      "secs_per_collection": 10,
      "lbs": 100,
      "max": 10,
    },
    "Fast Miner": {
      "category": "automated",
      "cost": {"dollars": 200},
      "gets": {"stone", "quartz"},
      "mats_per_collection": 2.5,
      "secs_per_collection": 5,
      "lbs": 1000,
      "max": 10,
    },
    "Quartz Miner": {
      "category": "automated",
      "cost": {"dollars": 400},
      "gets": {"quartz"},
      "mats_per_collection": 1,
      "secs_per_collection": 10,
      "lbs": 1000,
      "max": 10,
    },
    "Cargo Truck": {
      "category": "storage",
      "cost": {"dollars": 100},
      "capacity": 100,
      "lbs": 1000,
      "max": 10,
    },
    "Mining Kit": {
      "category": "manual",
      "cost": {"dollars": 10},
      "gets": {"stone", "quartz"},
      "mats_per_collection": 0.5,
      "max": 1,
    },
  };

  static String stringifyMachine(MachineObj machine) {
    // Returns a string in the format "[id]/[machine type]{/[num upgrades]}"
    if (machine.numUpgrades > 0) {
      return "${machine.id}/${machine.machine}/${machine.numUpgrades}";
    } else {
      return "${machine.id}/${machine.machine}";
    }
  }

  static MachineObj loadMachine(String machineStr) {
    // Accepts a string in the format "id/machineType{/num upgrades}"
    List<String> parts = machineStr.split("/");
    if (parts.length > 2 && parts[2] != "0") {
      return MachineObj(
        id: int.parse(parts[0]),
        machine: parts[1],
        numUpgrades: int.parse(parts[2]),
      );
    } else {
      return MachineObj(
        id: int.parse(parts[0]),
        machine: parts[1],
      );
    }
  }

  static String stringifyWholeInventory(MachineInventory inv) {
    String machinesStr = "";
    for (MachineObj machine in inv.machines) {
      machinesStr += "${stringifyMachine(machine)},";
    }
    String countsStr = "";
    for (String key in inv.counts.keys) {
      countsStr += "$key:${inv.counts[key]},";
    }
    return "$machinesStr,$countsStr,";
  }

  static MachineInventory loadWholeInventory(String invStr) {
    var inv = MachineInventory();

    List<String> machinesStr = invStr.split(",,")[0].split(",");
    for (String machineStr in machinesStr) {
      inv.machines.add(loadMachine(machineStr));
    }

    List<String> countsStr = invStr.split(",,")[1].split(",");
    for (String countStr in countsStr) {
      List<String> sides = countStr.split(":");
      inv.counts[sides[0]] = int.parse(countStr);
    }

    return inv;
  }
}

class MachineObj {
  MachineObj({required this.id, required this.machine, this.numUpgrades = 0}) {
    if (!MachineHelper.machines.keys.contains(machine)) {
      category = "scrap";
    } else {
      category = MachineHelper.machines[machine]!["category"];
    }
  }

  int id;
  String machine;
  late String category;
  int numUpgrades;

  int upgrade(userCurrencies) {
    bool canBeUpgraded = MachineHelper.machines.containsKey(machine) &&
        MachineHelper.machines[machine]!.containsKey("cost");
    if (canBeUpgraded) {
      var thisMachineInfo = MachineHelper.machines[machine]!;
      var currenciesNeeded = thisMachineInfo["cost"].keys();
      bool canAfford = true;
      // Check if can afford
      for (var currency in currenciesNeeded) {
        if (userCurrencies[currency] ?? 0 < thisMachineInfo["cost"][currency]) {
          canAfford = false;
          break;
        }
      }
      if (!canAfford) {
        return -1; // Cannot afford
      } else {
        // Charge user
        for (var currency in currenciesNeeded) {
          userCurrencies[currency] -= thisMachineInfo["cost"][currency];
        }
        numUpgrades++;
        return 0; // Success
      }
    } else {
      return -2; // Cannot upgrade
    }
  }

  String info() {
    // Get saved info
    String infoStr = "ID ${id + 1}\nLv$numUpgrades $machine";
    Map<String, dynamic>? basicInfo = MachineHelper.machines[machine];
    if (basicInfo != null) {
      // Get bonus info
      if (category == "automated") {
        double rate =
            ((numUpgrades + 1) * basicInfo["mats_per_collection"]! as double);
        infoStr += "\n$rate materials/${basicInfo["secs_per_collection"]!}s";
        // Include which materials can be mined?
      } else if (category == "manual") {
        double rate =
            ((numUpgrades + 1) * basicInfo["mats_per_collection"]! as double);
        if (rate >= 1) {
          infoStr += "\n$rate materials/tap";
        } else {
          infoStr += "\n${rate * 100}% chance of materials/tap";
        }
      } else if (category == "storage") {
        int cap = ((numUpgrades + 1) * basicInfo["capacity"]! as int);
        infoStr += "\nholds $cap materials";
      }
    }
    return infoStr;
  }
}

// One inventory holds all the machines for a floor.
class MachineInventory {
  List<MachineObj> machines = [];
  Map<String, int> counts = {};

  int makeMachine({required String machine}) {
    // Check currency
    if ((counts[machine] ?? 0) >=
        (MachineHelper.machines[machine]?["max"] ?? 0)) {
      return -1; // At capacity for this machine
    } else {
      machines.add(MachineObj(id: machines.length, machine: machine));
      return 0; // Success
    }
  }

  int checkWeight() {
    int lbs = 0;
    for (String machine in counts.keys) {
      int machineWeight = MachineHelper.machines[machine]?["lbs"] ?? 9999;
      lbs += machineWeight * counts[machine]!;
    }
    return lbs;
  }
}

class Inventories {
  List<MachineInventory> inv = [];
  Map<String, int> myCurrency = {};

  int newGame() {
    print("Starting new game...");
    // Reset belongings
    inv = [MachineInventory()];
    myCurrency = {"dollars": 10};
    // Hard-coded inventory for now
    inv[0].makeMachine(machine: "Cargo Truck");
    inv[0].makeMachine(machine: "Mining Kit");
    print("Successfully reset game");
    return 0; // success
  }

  int saveGame() {
    try {
      for (MachineInventory floorInv in inv) {
        MachineHelper.stringifyWholeInventory(floorInv); // Save this string
      }
      String progress = "floors:${inv.length};";
      for (String currency in myCurrency.keys) {
        progress += "$currency:${myCurrency[currency]};";
      }
      progress = progress.substring(0, progress.length - 1);
      // Save "progress"
      return 1; // failure, not implemented
    } catch (e) {
      return 1;
    }
  }

  int loadGame() {
    try {
      List<String> pieces = "floors:0;dollars:10".split(";"); // Load this
      // Load currency
      myCurrency = {};
      for (String piece in pieces.sublist(1)) {
        myCurrency[piece.split(":")[0]] = int.parse(piece.split(":")[1]);
      }
      // Load inventory
      inv = [];
      int floors = int.parse(pieces[0].split(":")[1]);
      for (int floor = 0; floor < floors; floor++) {
        print("Load floor:$floor");
        var floorInv = ""; // Load this
        inv.add(MachineHelper.loadWholeInventory(floorInv));
      }
      return 1; // failure, not implemented
    } catch (e) {
      return 1;
    }
  }
}
