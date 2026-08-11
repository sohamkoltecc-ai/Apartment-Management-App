import 'package:flutter/material.dart';
import '../payment/payment_screen.dart';
import '../booking/booking_screen.dart';
import '../notices/notice_screen.dart';
import '../maintenance/maintenance_screen.dart';
import '../profile/profile_screen.dart';
import '../visitors/visitor_screen.dart';
import '../services/services_screen.dart';

class DashboardScreen extends StatelessWidget {
  final String email;

  const DashboardScreen({
    super.key,
    required this.email,
  });

  String getUserName() {
    String name = email.split("@")[0];

    if (email.toLowerCase() == "ashrafjaha@gmail.com") {
      return "Ashrafjaha Khan";
    }

    if (email.toLowerCase() == "sneha@gmail.com") {
      return "Sneha";
    }

    return name[0].toUpperCase() + name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F6FA),

      // --------------------------------------------------
      // APP BAR
      // --------------------------------------------------
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: const Text(
          "Apartment Management",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const NoticeScreen(),
                ),
              );
            },
          ),
        ],
      ),

      // --------------------------------------------------
      // BODY
      // --------------------------------------------------
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // --------------------------------------------------
            // WELCOME HEADER
            // --------------------------------------------------
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 22),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xff5B2EFF),
                    Color(0xff8E24AA),
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 30,
                      color: Colors.deepPurple,
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Welcome back 👋",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),

                        const SizedBox(height: 3),

                        Text(
                          getUserName(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 4),

                        const Row(
                          children: [
                            Icon(
                              Icons.home,
                              color: Colors.white70,
                              size: 15,
                            ),
                            SizedBox(width: 5),
                            Text(
                              "Flat A-203 • Sunrise Residency",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // --------------------------------------------------
            // APARTMENT SUMMARY
            // --------------------------------------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
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
                child: Row(
                  children: [
                    Expanded(
                      child: summaryItem(
                        Icons.account_balance_wallet,
                        "₹2,500",
                        "Maintenance Due",
                        Colors.red,
                      ),
                    ),

                    Container(
                      height: 45,
                      width: 1,
                      color: Colors.grey.shade200,
                    ),

                    Expanded(
                      child: summaryItem(
                        Icons.build,
                        "1",
                        "Pending Issue",
                        Colors.orange,
                      ),
                    ),

                    Container(
                      height: 45,
                      width: 1,
                      color: Colors.grey.shade200,
                    ),

                    Expanded(
                      child: summaryItem(
                        Icons.campaign,
                        "3",
                        "Notices",
                        Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 22),

            // --------------------------------------------------
            // QUICK ACTIONS
            // --------------------------------------------------
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                "Quick Actions",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,

                // Smaller cards
                childAspectRatio: 2.0,

                children: [
                  buildCard(
                    context,
                    Icons.payment,
                    "Payments",
                    Colors.green,
                    const PaymentScreen(),
                  ),

                  buildCard(
                    context,
                    Icons.build,
                    "Maintenance",
                    Colors.orange,
                    const MaintenanceScreen(),
                  ),

                  buildCard(
                    context,
                    Icons.calendar_month,
                    "Booking",
                    Colors.blue,
                    const BookingScreen(),
                  ),

                  buildCard(
                    context,
                    Icons.campaign,
                    "Notices",
                    Colors.deepPurple,
                    const NoticeScreen(),
                  ),

                  // --------------------------------------------------
                  // VISITORS - ADDED
                  // --------------------------------------------------
                  buildCard(
                    context,
                    Icons.people,
                    "Visitors",
                    Colors.purple,
                    const VisitorScreen(),
                  ),

                  // --------------------------------------------------
                  // SOCIETY SERVICES - ADDED
                  // --------------------------------------------------
                  buildCard(
                    context,
                    Icons.home_repair_service,
                    "Society Services",
                    Colors.teal,
                    const ServicesScreen(),
                  ),

                  buildCard(
                    context,
                    Icons.person,
                    "Profile",
                    Colors.purple,
                    ProfileScreen(
                      email: email,
                    ),
                  ),

                  buildApartmentCard(context),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // --------------------------------------------------
            // LATEST UPDATE
            // --------------------------------------------------
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                "Latest Update",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const NoticeScreen(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
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
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 23,
                        backgroundColor: Colors.red.withOpacity(0.12),
                        child: const Icon(
                          Icons.campaign,
                          color: Colors.red,
                        ),
                      ),

                      const SizedBox(width: 14),

                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Important Notice",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: 4),

                            Text(
                              "Please clear your monthly maintenance payment before the due date.",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),

                            SizedBox(height: 5),

                            Text(
                              "8 August 2026",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // --------------------------------------------------
            // UPCOMING PAYMENT
            // --------------------------------------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xff673AB7),
                      Color(0xff512DA8),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.white24,
                      child: Icon(
                        Icons.calendar_today,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(width: 14),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Upcoming Payment",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),

                          SizedBox(height: 3),

                          Text(
                            "₹2,500",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 2),

                          Text(
                            "Due on 10 August 2026",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PaymentScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.deepPurple,
                        elevation: 0,
                      ),
                      child: const Text(
                        "View",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  // --------------------------------------------------
  // SUMMARY ITEM
  // --------------------------------------------------
  Widget summaryItem(
    IconData icon,
    String value,
    String title,
    Color color,
  ) {
    return Column(
      children: [
        Icon(
          icon,
          color: color,
          size: 22,
        ),

        const SizedBox(height: 6),

        Text(
          value,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 2),

        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  // --------------------------------------------------
  // QUICK ACTION CARD
  // --------------------------------------------------
  Widget buildCard(
    BuildContext context,
    IconData icon,
    String title,
    Color color,
    Widget page,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => page,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 17,
              backgroundColor: color.withOpacity(0.12),
              child: Icon(
                icon,
                color: color,
                size: 19,
              ),
            ),

            const SizedBox(width: 8),

            Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --------------------------------------------------
  // MY APARTMENT CARD
  // --------------------------------------------------
  Widget buildApartmentCard(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("My Apartment"),
              content: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.home,
                      color: Colors.deepPurple,
                    ),
                    title: Text("Flat Number"),
                    subtitle: Text("A-203"),
                  ),ListTile(
                    leading: Icon(
                      Icons.apartment,
                      color: Colors.blue,
                    ),
                    title: Text("Building"),
                    subtitle: Text("Sunrise Residency"),
                  ),

                  ListTile(
                    leading: Icon(
                      Icons.people,
                      color: Colors.green,
                    ),
                    title: Text("Residents"),
                    subtitle: Text("Apartment Resident"),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Close"),
                ),
              ],
            );
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 17,
              backgroundColor: Colors.deepPurple.withOpacity(0.12),
              child: const Icon(
                Icons.home,
                color: Colors.deepPurple,
                size: 19,
              ),
            ),

            const SizedBox(width: 8),

            const Text(
              "My Apartment",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}