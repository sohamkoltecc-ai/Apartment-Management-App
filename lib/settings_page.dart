import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notifications = true;
  bool darkMode = false;

  void showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void showChangePasswordDialog() {
    final passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Change Password"),
          content: TextField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: "New Password",
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
                Navigator.pop(context);

                showMessage("Password updated successfully");
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void showAboutDialogBox() {
    showAboutDialog(
      context: context,
      applicationName: "Apartment Management App",
      applicationVersion: "1.0.0",
      applicationLegalese: "Apartment Management System",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings"), centerTitle: true),
      body: ListView(
        children: [
          // Profile
          ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: const Text("My Profile"),
            subtitle: const Text("View & Edit Profile"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              showMessage("Profile page coming soon");
            },
          ),

          const Divider(),

          // Notifications
          SwitchListTile(
            secondary: const Icon(Icons.notifications),
            title: const Text("Notifications"),
            subtitle: const Text("Receive app notifications"),
            value: notifications,
            onChanged: (value) {
              setState(() {
                notifications = value;
              });
            },
          ),

          // Dark Mode
          SwitchListTile(
            secondary: const Icon(Icons.dark_mode),
            title: const Text("Dark Mode"),
            subtitle: const Text("Change app appearance"),
            value: darkMode,
            onChanged: (value) {
              setState(() {
                darkMode = value;
              });

              showMessage(
                darkMode ? "Dark Mode enabled" : "Dark Mode disabled",
              );
            },
          ),

          const Divider(),

          // Change Password
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text("Change Password"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: showChangePasswordDialog,
          ),

          // About
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text("About App"),
            subtitle: const Text("Version 1.0.0"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: showAboutDialogBox,
          ),

          // Help
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text("Help & Support"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              showMessage("Contact your society administrator for help");
            },
          ),

          const Divider(),

          // Logout
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Logout", style: TextStyle(color: Colors.red)),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Logout"),
                    content: const Text("Are you sure you want to logout?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          showMessage("Logged out");
                        },
                        child: const Text("Logout"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
