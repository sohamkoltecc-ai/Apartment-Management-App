import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MaintenanceScreen extends StatefulWidget {
  const MaintenanceScreen({super.key});

  @override
  State<MaintenanceScreen> createState() => _MaintenanceScreenState();
}

class _MaintenanceScreenState extends State<MaintenanceScreen> {
  List<Map<String, dynamic>> maintenanceRequests = [];

  final List<Map<String, dynamic>> defaultRequests = [
    {
      "title": "Water Leakage",
      "status": "Pending",
      "description":
          "Water leakage complaint has been submitted and is waiting for maintenance.",
      "category": "Plumbing",
    },
    {
      "title": "Electricity Issue",
      "status": "In Progress",
      "description":
          "The electricity issue is currently being checked by the maintenance team.",
      "category": "Electricity",
    },
    {
      "title": "Cleaning Complaint",
      "status": "Resolved",
      "description":
          "The cleaning complaint has been successfully resolved.",
      "category": "Cleaning",
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadMaintenanceRequests();
  }

  Future<void> _loadMaintenanceRequests() async {
    final prefs = await SharedPreferences.getInstance();

    final savedData = prefs.getString("maintenance_requests");

    if (savedData != null) {
      final List<dynamic> decodedData = jsonDecode(savedData);

      setState(() {
        maintenanceRequests =
            decodedData.map((item) {
              return Map<String, dynamic>.from(item);
            }).toList();
      });
    } else {
      setState(() {
        maintenanceRequests = List<Map<String, dynamic>>.from(
          defaultRequests,
        );
      });

      await _saveMaintenanceRequests();
    }
  }

  Future<void> _saveMaintenanceRequests() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      "maintenance_requests",
      jsonEncode(maintenanceRequests),
    );
  }

  void _showReportIssueForm() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    String selectedCategory = "General";

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 45,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "Report New Issue",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    const Text(
                      "Tell us about the maintenance problem.",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 20),

                    TextField(
                      controller: titleController,
                      maxLength: 40,
                      decoration: InputDecoration(
                        labelText: "Issue Title",
                        hintText: "Example: Broken Fan",
                        prefixIcon: const Icon(Icons.title),
                        counterText: "",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    DropdownButtonFormField<String>(
                      value: selectedCategory,
                      decoration: InputDecoration(
                        labelText: "Category",
                        prefixIcon: const Icon(Icons.category),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: "General",
                          child: Text("General"),
                        ),
                        DropdownMenuItem(
                          value: "Plumbing",
                          child: Text("Plumbing"),
                        ),
                        DropdownMenuItem(
                          value: "Electricity",
                          child: Text("Electricity"),
                        ),
                        DropdownMenuItem(
                          value: "Cleaning",
                          child: Text("Cleaning"),
                        ),
                        DropdownMenuItem(
                          value: "Other",
                          child: Text("Other"),
                        ),
                      ],
                      onChanged: (value) {
                        setModalState(() {
                          selectedCategory = value!;
                        });
                      },
                    ),

                    const SizedBox(height: 16),

                    TextField(
                      controller: descriptionController,
                      maxLines: 3,
                      maxLength: 200,
                      decoration: InputDecoration(
                        labelText: "Description",
                        hintText: "Describe the problem...",
                        prefixIcon: const Icon(Icons.description),
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (titleController.text.trim().isEmpty ||
                              descriptionController.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Please enter the issue title and description.",
                                ),
                              ),
                            );
                            return;
                          }

                          setState(() {
                            maintenanceRequests.insert(
                              0,
                              {
                                "title": titleController.text.trim(),
                                "status": "Pending",
                                "description":
                                    descriptionController.text.trim(),
                                "category": selectedCategory,
                              },
                            );
                          });

                          await _saveMaintenanceRequests();

                          if (context.mounted) {
                            Navigator.pop(context);
                          }

                          if (mounted) {
                            ScaffoldMessenger.of(this.context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Maintenance issue reported successfully!",
                                ),
                                backgroundColor: Colors.green,
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Submit Complaint",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  IconData _getIcon(String category) {
    switch (category) {
      case "Plumbing":
        return Icons.plumbing;

      case "Electricity":
        return Icons.electrical_services;

      case "Cleaning":
        return Icons.cleaning_services;

      default:
        return Icons.build;
    }
  }

  Color _getIconColor(String category) {
    switch (category) {
      case "Plumbing":
        return Colors.blue;

      case "Electricity":
        return Colors.orange;

      case "Cleaning":
        return Colors.green;

      default:
        return Colors.deepPurple;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Resolved":
        return Colors.green;

      case "In Progress":
        return Colors.blue;

      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Maintenance"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),

      body: maintenanceRequests.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text(
                  "Maintenance Requests",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                const Text(
                  "Track your maintenance complaints and their status",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 20),

                ...maintenanceRequests.map(
                  (request) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _maintenanceCard(
                      icon: _getIcon(request["category"]),
                      iconColor: _getIconColor(request["category"]),
                      title: request["title"],
                      status: request["status"],
                      statusColor: _getStatusColor(request["status"]),
                      description: request["description"],
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: _showReportIssueForm,
                    icon: const Icon(Icons.add),
                    label: const Text(
                      "Report New Issue",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
    );
  }

  Widget _maintenanceCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String status,
    required Color statusColor,
    required String description,
  }) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: iconColor.withOpacity(0.12),
              child: Icon(
                icon,
                color: iconColor,
                size: 23,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(width: 8),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          status,
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 7),

                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}