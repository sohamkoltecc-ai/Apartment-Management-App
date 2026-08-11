import 'package:flutter/material.dart';

class VisitorScreen extends StatefulWidget {
  const VisitorScreen({super.key});

  @override
  State<VisitorScreen> createState() => _VisitorScreenState();
}

class _VisitorScreenState extends State<VisitorScreen> {
  // --------------------------------------------------
  // SHARED VISITOR LIST
  // --------------------------------------------------
  // Because this is static, the list remains available
  // when you leave this screen and open it again.
  static final List<Map<String, dynamic>> _visitors = [
    {
      'name': 'Rahul Sharma',
      'purpose': 'Guest',
      'time': '5:30 PM',
      'status': 'Expected',
    },
    {
      'name': 'Priya Patel',
      'purpose': 'Delivery',
      'time': '6:15 PM',
      'status': 'Inside',
    },
    {
      'name': 'Amit Verma',
      'purpose': 'Friend',
      'time': '2:00 PM',
      'status': 'Left',
    },
  ];

  List<Map<String, dynamic>> get visitors => _visitors;

  // --------------------------------------------------
  // COLORS
  // --------------------------------------------------
  final Color primaryPurple = const Color(0xff673AB7);
  final Color lightBackground = const Color(0xffF4F6FA);

  // --------------------------------------------------
  // STATUS COLOR
  // --------------------------------------------------
  Color _statusColor(String status) {
    switch (status) {
      case 'Inside':
        return Colors.green;
      case 'Expected':
        return Colors.orange;
      case 'Left':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  // --------------------------------------------------
  // STATUS ICON
  // --------------------------------------------------
  IconData _statusIcon(String status) {
    switch (status) {
      case 'Inside':
        return Icons.login_rounded;
      case 'Expected':
        return Icons.schedule_rounded;
      case 'Left':
        return Icons.logout_rounded;
      default:
        return Icons.person;
    }
  }

  // --------------------------------------------------
  // ADD VISITOR
  // --------------------------------------------------
  void _addVisitor() {
    final nameController = TextEditingController();
    final purposeController = TextEditingController();
    final phoneController = TextEditingController();

    String selectedPurpose = 'Guest';

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
              title: const Text(
                'Add Visitor',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Visitor Name',
                        prefixIcon: const Icon(Icons.person_outline),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        prefixIcon: const Icon(Icons.phone_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    DropdownButtonFormField<String>(
                      value: selectedPurpose,
                      decoration: InputDecoration(
                        labelText: 'Visitor Type',
                        prefixIcon: const Icon(Icons.category_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'Guest',
                          child: Text('Guest'),
                        ),
                        DropdownMenuItem(
                          value: 'Friend',
                          child: Text('Friend'),
                        ),
                        DropdownMenuItem(
                          value: 'Delivery',
                          child: Text('Delivery'),
                        ),
                        DropdownMenuItem(
                          value: 'Family',
                          child: Text('Family'),
                        ),
                        DropdownMenuItem(
                          value: 'Service',
                          child: Text('Service'),
                        ),
                        DropdownMenuItem(
                          value: 'Other',
                          child: Text('Other'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setDialogState(() {
                            selectedPurpose = value;
                          });
                        }
                      },
                    ),

                    const SizedBox(height: 14),

                    TextField(
                      controller: purposeController,
                      decoration: InputDecoration(
                        labelText: 'Purpose / Note',
                        prefixIcon: const Icon(Icons.notes_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                  child: const Text('Cancel'),
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryPurple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    final name = nameController.text.trim();

                    if (name.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter visitor name'),
                        ),
                      );
                      return;
                    }

                    final now = TimeOfDay.now();

                    final formattedTime = now.format(context);

                    setState(() {
                      visitors.insert(0, {
                        'name': name,
                        'purpose': selectedPurpose,
                        'note': purposeController.text.trim(),
                        'phone': phoneController.text.trim(),
                        'time': formattedTime,
                        'status': 'Expected',
                      });
                    });

                    Navigator.pop(dialogContext);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('$name added successfully'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  child: const Text(
                    'Add Visitor',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // --------------------------------------------------
  // MARK AS INSIDE
  // --------------------------------------------------
  void _markAsInside(int index) {
    setState(() {
      visitors[index]['status'] = 'Inside';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Visitor marked as Inside'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // --------------------------------------------------
  // MARK AS LEFT
  // --------------------------------------------------
  void _markAsLeft(int index) {
    setState(() {
      visitors[index]['status'] = 'Left';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Visitor marked as Left'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // --------------------------------------------------
  // DELETE VISITOR
  // --------------------------------------------------
  void _deleteVisitor(int index) {
    final visitorName = visitors[index]['name'];

    setState(() {
      visitors.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$visitorName removed'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // --------------------------------------------------
  // BUILD
  // --------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final expectedCount = visitors
        .where((visitor) => visitor['status'] == 'Expected')
        .length;

    final insideCount = visitors
        .where((visitor) => visitor['status'] == 'Inside')
        .length;

    final leftCount = visitors
        .where((visitor) => visitor['status'] == 'Left')
        .length;

    return Scaffold(
      backgroundColor: lightBackground,

      // --------------------------------------------------
      // APP BAR
      // --------------------------------------------------
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryPurple,
        foregroundColor: Colors.white,
        title: const Text(
          'Visitors',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      // --------------------------------------------------
      // ADD BUTTON
      // --------------------------------------------------
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primaryPurple,
        foregroundColor: Colors.white,
        onPressed: _addVisitor,
        icon: const Icon(Icons.person_add_alt_1),
        label: const Text(
          'Add Visitor',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // --------------------------------------------------
      // BODY
      // --------------------------------------------------
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // --------------------------------------------------
            // PURPLE HEADER
            // --------------------------------------------------
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(
                20,
                22,
                20,
                26,
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xff5B2EFF),
                    Color(0xff8E24AA),
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Visitor Management',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 6),

                  Text(
                    'Keep track of everyone visiting your apartment.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // --------------------------------------------------
            // SUMMARY
            // --------------------------------------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                children: [
                  Expanded(
                    child: _SummaryCard(
                      title: 'Expected',
                      count: expectedCount,
                      icon: Icons.schedule_rounded,
                      color: Colors.orange,
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: _SummaryCard(
                      title: 'Inside',
                      count: insideCount,
                      icon: Icons.login_rounded,
                      color: Colors.green,
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: _SummaryCard(
                      title: 'Left',
                      count: leftCount,
                      icon: Icons.logout_rounded,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // --------------------------------------------------
            // TODAY'S VISITORS TITLE
            // --------------------------------------------------
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                children: [
                  Text(
                    "Today's Visitors",
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // --------------------------------------------------
            // EMPTY STATE
            // --------------------------------------------------
            if (visitors.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Column(
                    children: [
                      Icon(
                        Icons.people_outline,
                        size: 55,
                        color: Colors.deepPurple,
                      ),
                      SizedBox(height: 12),
                      Text(
                        'No visitors yet',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Tap "Add Visitor" to add someone visiting your apartment.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // --------------------------------------------------
            // VISITOR LIST
            // --------------------------------------------------
            ...visitors.asMap().entries.map((entry) {
              final index = entry.key;
              final visitor = entry.value;

              final status = visitor['status'] as String;
              final statusColor = _statusColor(status);

              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 6,
                ),
                child: _VisitorCard(
                  visitor: visitor,
                  status: status,
                  statusColor: statusColor,
                  statusIcon: _statusIcon(status),
                  onInside: () => _markAsInside(index),
                  onLeft: () => _markAsLeft(index),
                  onDelete: () => _deleteVisitor(index),
                ),
              );
            }),

            const SizedBox(height: 90),
          ],
        ),
      ),
    );
  }
}

// ==========================================================
// SUMMARY CARD
// ==========================================================

class _SummaryCard extends StatelessWidget {
  final String title;
  final int count;
  final IconData icon;
  final Color color;

  const _SummaryCard({
    required this.title,
    required this.count,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 21,
            backgroundColor: color.withOpacity(0.12),
            child: Icon(
              icon,
              color: color,
              size: 22,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            '$count',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 2),

          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================================
// VISITOR CARD
// ==========================================================

class _VisitorCard extends StatelessWidget {
  final Map<String, dynamic> visitor;
  final String status;
  final Color statusColor;
  final IconData statusIcon;
  final VoidCallback onInside;
  final VoidCallback onLeft;
  final VoidCallback onDelete;

  const _VisitorCard({
    required this.visitor,
    required this.status,
    required this.statusColor,
    required this.statusIcon,
    required this.onInside,
    required this.onLeft,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // --------------------------------------------------
            // TOP PART
            // --------------------------------------------------
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 27,
                  backgroundColor:
                      Colors.deepPurple.withOpacity(0.10),
                  child: const Icon(
                    Icons.person,
                    color: Colors.deepPurple,
                    size: 28,
                  ),
                ),

                const SizedBox(width: 13),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        visitor['name'],
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Row(
                        children: [
                          const Icon(
                            Icons.category_outlined,
                            size: 15,
                            color: Colors.grey,
                          ),

                          const SizedBox(width: 5),

                          Text(
                            visitor['purpose'],
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // STATUS
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        statusIcon,
                        size: 14,
                        color: statusColor,
                      ),

                      const SizedBox(width: 4),

                      Text(
                        status,
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            // --------------------------------------------------
            // DETAILS
            // --------------------------------------------------
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: const Color(0xffF7F7FA),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.access_time_rounded,
                    size: 17,
                    color: Colors.deepPurple,
                  ),

                  const SizedBox(width: 6),

                  Text(
                    visitor['time'],
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  if (visitor['phone'] != null &&
                      visitor['phone'].toString().isNotEmpty) ...[
                    const SizedBox(width: 18),

                    const Icon(
                      Icons.phone_outlined,
                      size: 16,
                      color: Colors.deepPurple,
                    ),

                    const SizedBox(width: 5),

                    Expanded(
                      child: Text(
                        visitor['phone'],
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // --------------------------------------------------
            // NOTE
            // --------------------------------------------------
            if (visitor['note'] != null &&
                visitor['note'].toString().isNotEmpty) ...[
              const SizedBox(height: 10),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Note: ${visitor['note']}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ),
            ],

            const SizedBox(height: 12),

            // --------------------------------------------------
            // ACTIONS
            // --------------------------------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (status == 'Expected')
                  TextButton.icon(
                    onPressed: onInside,
                    icon: const Icon(
                      Icons.login_rounded,
                      size: 17,
                    ),
                    label: const Text('Mark Inside'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.green,
                    ),
                  ),

                if (status == 'Inside')
                  TextButton.icon(
                    onPressed: onLeft,
                    icon: const Icon(
                      Icons.logout_rounded,
                      size: 17,
                    ),
                    label: const Text('Mark Left'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.deepPurple,
                    ),
                  ),

                IconButton(
                  onPressed: onDelete,
                  tooltip: 'Delete Visitor',
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.redAccent,
                    size: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}