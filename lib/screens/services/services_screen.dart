import 'package:flutter/material.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  final List<Map<String, dynamic>> services = [
    {
      'title': 'Watchman',
      'phone': '9876543210',
      'description': 'Security and gate assistance',
      'icon': Icons.security_rounded,
      'color': Colors.deepPurple,
      'available': '24 Hours',
    },
    {
      'title': 'Electrician',
      'phone': '9876500001',
      'description': 'Electrical repairs and maintenance',
      'icon': Icons.electrical_services_rounded,
      'color': Colors.orange,
      'available': '8 AM - 8 PM',
    },
    {
      'title': 'Plumber',
      'phone': '9876500002',
      'description': 'Water and plumbing assistance',
      'icon': Icons.plumbing_rounded,
      'color': Colors.blue,
      'available': '8 AM - 8 PM',
    },
    {
      'title': 'Cleaner',
      'phone': '9876500003',
      'description': 'Cleaning and housekeeping',
      'icon': Icons.cleaning_services_rounded,
      'color': Colors.green,
      'available': '7 AM - 6 PM',
    },
  ];

  void _showServiceDetails(Map<String, dynamic> service) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final Color color = service['color'];

        return Container(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 25),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(28),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 45,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              const SizedBox(height: 22),

              CircleAvatar(
                radius: 35,
                backgroundColor: color.withOpacity(0.12),
                child: Icon(
                  service['icon'],
                  color: color,
                  size: 35,
                ),
              ),

              const SizedBox(height: 14),

              Text(
                service['title'],
                style: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                service['description'],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 22),

              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0xffF4F6FA),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.phone_rounded,
                      color: color,
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Contact Number',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          service['phone'],
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.access_time_rounded,
                      color: Colors.green,
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Availability',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          service['available'],
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        _showRequestDialog(service['title']);
                      },
                      icon: const Icon(Icons.build_circle_outlined),
                      label: const Text('Request'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Calling ${service['title']}...',
                            ),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      icon: const Icon(Icons.phone),
                      label: const Text('Contact'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: color,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showRequestDialog(String serviceName) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          title: Text(
            'Request $serviceName',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Describe what you need help with.',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              TextField(
                controller: controller,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Example: Water leakage in bathroom...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.text.trim().isEmpty) {
                  return;
                }

                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Service request submitted successfully.',
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              child: const Text('Submit Request'),
            ),
          ],
        );
      },
    );
  }

  void _showEmergencyDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          title: const Row(
            children: [
              Icon(
                Icons.emergency_rounded,
                color: Colors.red,
              ),
              SizedBox(width: 10),
              Text('Emergency'),
            ],
          ),
          content: const Text(
            'For immediate emergency assistance, contact the emergency services below.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Emergency numbers: 100 / 108',
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              icon: const Icon(Icons.phone),
              label: const Text('Contact'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F6FA),

      appBar: AppBar(
        title: const Text(
          'Society Services',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.deepPurple,
      ),

      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
        children: [
          // --------------------------------------------------
          // HEADER
          // --------------------------------------------------
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xff5B2EFF),
                  Color(0xff8E24AA),
                ],
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white24,
                  child: Icon(
                    Icons.home_work_rounded,
                    color: Colors.white,
                    size: 32,
                  ),
                ),

                const SizedBox(width: 15),

                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Society Support',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'How can we help you?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Contact society staff whenever you need assistance.',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // --------------------------------------------------
          // QUICK REQUEST
          // --------------------------------------------------
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Available Services',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              TextButton.icon(
                onPressed: () {
                  _showRequestDialog('General Service');
                },
                icon: const Icon(
                  Icons.add_circle_outline,
                  size: 18,
                ),
                label: const Text('Request'),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // --------------------------------------------------
          // SERVICE CARDS
          // --------------------------------------------------
          ...services.map(
            (service) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _ServiceCard(
                service: service,
                onTap: () {
                  _showServiceDetails(service);
                },
              ),
            ),
          ),

          const SizedBox(height: 10),

          // --------------------------------------------------
          // EMERGENCY SECTION
          // --------------------------------------------------
          const Text(
            'Emergency Assistance',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: _showEmergencyDialog,
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.08),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.red.withOpacity(0.15),
                ),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 27,
                    backgroundColor: Colors.red,
                    child: Icon(
                      Icons.emergency_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),

                  const SizedBox(width: 14),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Emergency Helpline',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Police: 100  •  Ambulance: 108',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Icon(
                    Icons.phone_forwarded_rounded,
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 22),

          // --------------------------------------------------
          // FOOTER
          // --------------------------------------------------
          Center(
            child: Text(
              'Sunrise Residency • Society Support',
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================================
// SERVICE CARD
// ==========================================================

class _ServiceCard extends StatelessWidget {
  final Map<String, dynamic> service;
  final VoidCallback onTap;

  const _ServiceCard({
    required this.service,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = service['color'];

    return Card(
      elevation: 1.5,
      shadowColor: Colors.black12,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  service['icon'],
                  color: color,
                  size: 29,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service['title'],
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      service['description'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),

                    const SizedBox(height: 7),

                    Row(
                      children: [
                        Icon(
                          Icons.phone_outlined,
                          size: 15,
                          color: color,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          service['phone'],
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.10),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'Available',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xffF4F6FA),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}