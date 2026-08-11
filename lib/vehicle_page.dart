import 'package:flutter/material.dart';
import 'vehicle.dart';

class VehiclePage extends StatefulWidget {
  const VehiclePage({super.key});

  @override
  State<VehiclePage> createState() => _VehiclePageState();
}

class _VehiclePageState extends State<VehiclePage> {
  final ownerController = TextEditingController();
  final numberController = TextEditingController();
  final typeController = TextEditingController();

  List<Vehicle> vehicles = [];

  void addVehicle() {
    if (ownerController.text.isNotEmpty &&
        numberController.text.isNotEmpty &&
        typeController.text.isNotEmpty) {
      setState(() {
        vehicles.add(
          Vehicle(
            ownerName: ownerController.text,
            vehicleNumber: numberController.text,
            vehicleType: typeController.text,
          ),
        );
      });

      ownerController.clear();
      numberController.clear();
      typeController.clear();
    }
  }

  void removeVehicle(int index) {
    setState(() {
      vehicles.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Vehicles")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: ownerController,
              decoration: const InputDecoration(labelText: "Owner Name"),
            ),
            TextField(
              controller: numberController,
              decoration: const InputDecoration(labelText: "Vehicle Number"),
            ),
            TextField(
              controller: typeController,
              decoration: const InputDecoration(labelText: "Vehicle Type"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: addVehicle,
              child: const Text("Add Vehicle"),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: vehicles.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.directions_car),
                      title: Text(vehicles[index].vehicleNumber),
                      subtitle: Text(
                        "${vehicles[index].ownerName}\n"
                        "${vehicles[index].vehicleType}",
                      ),
                      isThreeLine: true,
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => removeVehicle(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
