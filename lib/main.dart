import 'package:flutter/material.dart';

import 'security_page.dart';
import 'vehicle_page.dart';
import 'service_page.dart';
import 'settings_page.dart';

void main() {
  runApp(const ApartmentManagementApp());
}

class ApartmentManagementApp extends StatelessWidget {
  const ApartmentManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Apartment Management',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 118, 194, 31),
        ),
        useMaterial3: true,
      ),
      home: const DashboardPage(),
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int selectedIndex = 0;

  void _setPageIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  List<Widget> get pages => [
    HomePage(onTabSelected: _setPageIndex),
    const SecurityPage(),
    const VehiclePage(),
    const ServicesPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],

      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),
            label: 'Visitors',
          ),
          NavigationDestination(
            icon: Icon(Icons.directions_car_outlined),
            selectedIcon: Icon(Icons.directions_car),
            label: 'Vehicles',
          ),
          NavigationDestination(
            icon: Icon(Icons.support_agent_outlined),
            selectedIcon: Icon(Icons.support_agent),
            label: 'Services',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final ValueChanged<int> onTabSelected;

  const HomePage({super.key, required this.onTabSelected});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Apartment Management',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome 👋',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 5),

            const Text(
              'Manage your apartment easily',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 186, 49, 49),
              ),
            ),

            const SizedBox(height: 25),

            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,

              children: [
                _DashboardCard(
                  icon: Icons.people,
                  title: 'Visitors',
                  subtitle: 'Manage visitors',
                  onTap: () => onTabSelected(1),
                ),

                _DashboardCard(
                  icon: Icons.directions_car,
                  title: 'Vehicles',
                  subtitle: 'Manage vehicles',
                  onTap: () => onTabSelected(2),
                ),

                _DashboardCard(
                  icon: Icons.support_agent,
                  title: 'Services',
                  subtitle: 'Society contacts',
                  onTap: () => onTabSelected(3),
                ),

                _DashboardCard(
                  icon: Icons.settings,
                  title: 'Settings',
                  subtitle: 'App settings',
                  onTap: () => onTabSelected(4),
                ),
              ],
            ),

            const SizedBox(height: 25),

            const Text(
              'Quick Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            Card(
              child: ListTile(
                leading: const Icon(Icons.security, size: 35),
                title: const Text(
                  'Security & Visitors',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text('Manage visitor entry and exit'),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.contact_phone, size: 35),
                title: const Text(
                  'Emergency Contacts',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text('Quick access to society services'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _DashboardCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 42),

              const SizedBox(height: 10),

              Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
