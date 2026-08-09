import 'package:flutter/material.dart';
import 'visitor.dart';

class SecurityPage extends StatefulWidget {
  const SecurityPage({super.key});

  @override
  State<SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  final TextEditingController controller = TextEditingController();

  List<Visitor> visitors = [];

  void addVisitor() {
    if (controller.text.isNotEmpty) {
      setState(() {
        visitors.add(Visitor(name: controller.text));
      });

      controller.clear();
    }
  }

  void approveVisitor(int index) {
    setState(() {
      visitors[index].status = "Approved";
    });
  }

  void exitVisitor(int index) {
    setState(() {
      visitors[index].status = "Exited";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Visitor Management")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: "Visitor Name",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: addVisitor,
                ),
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: visitors.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(visitors[index].name),
                  subtitle: Text(visitors[index].status),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () => approveVisitor(index),
                        child: const Text("Approve"),
                      ),
                      const SizedBox(width: 5),
                      ElevatedButton(
                        onPressed: () => exitVisitor(index),
                        child: const Text("Exit"),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
