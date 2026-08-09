import 'package:flutter/material.dart';
import 'service.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  // Change to true when an admin is logged in.
  bool isAdmin = false;

  final List<Service> services = [
    Service(name: "Watchman", contact: "9876543210"),
    Service(name: "Electrician", contact: "9876500001"),
    Service(name: "Plumber", contact: "9876500002"),
    Service(name: "Cleaner", contact: "9876500003"),
    Service(name: "Emergency", contact: "100 / 108"),
  ];

  void editContact(int index) {
    final TextEditingController controller = TextEditingController(
      text: services[index].contact,
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit ${services[index].name}"),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              labelText: "Contact Number",
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.text.trim().isNotEmpty) {
                  setState(() {
                    services[index].contact = controller.text.trim();
                  });
                }

                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Society Services"), centerTitle: true),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];

          return Card(
            child: ListTile(
              leading: CircleAvatar(
                child: Icon(
                  service.name == "Emergency"
                      ? Icons.emergency
                      : Icons.support_agent,
                ),
              ),
              title: Text(
                service.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(service.contact),
              trailing: isAdmin
                  ? IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => editContact(index),
                    )
                  : null,
            ),
          );
        },
      ),
    );
  }
}
