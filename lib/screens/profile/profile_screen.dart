import 'package:flutter/material.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  final String email;

  const ProfileScreen({
    super.key,
    required this.email,
  });

  String getUserName() {
    switch (email.toLowerCase()) {
      case "ashrafjaha@gmail.com":
        return "Ashrafjaha Khan";

      case "sneha@gmail.com":
      case "sneha019@gmail.com":
        return "Sneha";

      case "sanchita@gmail.com":
        return "Sanchita";

      default:
        return email.split("@")[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),

          child: Column(
            children: [

              const SizedBox(height: 10),

              // Profile Icon
              const CircleAvatar(
                radius: 55,
                backgroundColor: Colors.deepPurple,
                child: Icon(
                  Icons.person,
                  size: 55,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 15),

              // User Name
              Text(
                getUserName(),
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 5),

              const Text(
                "Apartment Resident",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 25),

              // Email
              Card(
                elevation: 2,
                child: ListTile(
                  leading: const Icon(
                    Icons.email,
                    color: Colors.deepPurple,
                  ),
                  title: const Text(
                    "Email",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(email),
                ),
              ),

              const SizedBox(height: 8),

              // Phone
              Card(
                elevation: 2,
                child: const ListTile(
                  leading: Icon(
                    Icons.phone,
                    color: Colors.green,
                  ),
                  title: Text(
                    "Phone",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text("+91 9876543210"),
                ),
              ),

              const SizedBox(height: 8),

              // Flat Number
              Card(
                elevation: 2,
                child: const ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Colors.orange,
                  ),
                  title: Text(
                    "Flat Number",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text("A-203"),
                ),
              ),

              const SizedBox(height: 8),

              // Building
              Card(
                elevation: 2,
                child: const ListTile(
                  leading: Icon(
                    Icons.apartment,
                    color: Colors.blue,
                  ),
                  title: Text(
                    "Building",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text("Sunrise Residency"),
                ),
              ),

              const SizedBox(height: 25),

              // Logout Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),

                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                      (route) => false,
                    );
                  },

                  icon: const Icon(Icons.logout),

                  label: const Text(
                    "Logout",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}