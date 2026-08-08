import 'package:flutter/material.dart';

class NoticeScreen extends StatelessWidget {
  const NoticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color purple = Color(0xFF5125D8);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F5FF),

      // =========================================================
      // APP BAR
      // =========================================================

      appBar: AppBar(
        backgroundColor: purple,
        elevation: 0,

        title: const Text(
          'Notices',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),

        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),

      // =========================================================
      // NOTICE LIST
      // =========================================================

      body: ListView(
        padding: const EdgeInsets.all(16),

        children: [

          // =====================================================
          // PAGE TITLE
          // =====================================================

          const Text(
            'Apartment Notices',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            'Latest updates and announcements',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 20),

          // =====================================================
          // IMPORTANT NOTICE
          // =====================================================

          NoticeCard(
            icon: Icons.campaign,
            iconColor: Colors.red,
            title: 'Important Notice',
            date: '8 August 2026',
            message:
                'All residents are requested to clear their monthly maintenance payment before the due date.',
            isImportant: true,
          ),

          const SizedBox(height: 14),

          // =====================================================
          // WATER NOTICE
          // =====================================================

          NoticeCard(
            icon: Icons.water_drop,
            iconColor: Colors.blue,
            title: 'Water Supply Notice',
            date: '7 August 2026',
            message:
                'Water supply may be temporarily affected tomorrow from 10:00 AM to 1:00 PM due to maintenance work.',
          ),

          const SizedBox(height: 14),

          // =====================================================
          // CLEANING NOTICE
          // =====================================================

          NoticeCard(
            icon: Icons.cleaning_services,
            iconColor: Colors.green,
            title: 'Cleaning Schedule',
            date: '5 August 2026',
            message:
                'Common areas and corridors will be cleaned every Saturday. Residents are requested to keep the corridors clear.',
          ),

          const SizedBox(height: 14),

          // =====================================================
          // PARKING NOTICE
          // =====================================================

          NoticeCard(
            icon: Icons.local_parking,
            iconColor: Colors.orange,
            title: 'Parking Notice',
            date: '3 August 2026',
            message:
                'Please park your vehicles only in the designated parking spaces assigned to your apartment.',
          ),

          const SizedBox(height: 14),

          // =====================================================
          // SECURITY NOTICE
          // =====================================================

          NoticeCard(
            icon: Icons.security,
            iconColor: Colors.purple,
            title: 'Security Reminder',
            date: '1 August 2026',
            message:
                'Residents are requested to ensure that the main entrance is properly closed after entering or leaving the building.',
          ),
        ],
      ),
    );
  }
}


// =============================================================
// NOTICE CARD
// =============================================================

class NoticeCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String date;
  final String message;
  final bool isImportant;

  const NoticeCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.date,
    required this.message,
    this.isImportant = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(17),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(18),

        border: isImportant
            ? Border.all(
                color: Colors.red.withOpacity(0.35),
                width: 1.3,
              )
            : null,

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          // ===================================================
          // TITLE ROW
          // ===================================================

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              // ICON
              Container(
                width: 48,
                height: 48,

                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),

                child: Icon(
                  icon,
                  color: iconColor,
                  size: 25,
                ),
              ),

              const SizedBox(width: 13),

              // TITLE + DATE
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    Row(
                      children: [

                        Expanded(
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        if (isImportant)
                          Container(
                            padding:
                                const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),

                            decoration: BoxDecoration(
                              color: Colors.red
                                  .withOpacity(0.10),
                              borderRadius:
                                  BorderRadius.circular(8),
                            ),

                            child: const Text(
                              'IMPORTANT',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 5),

                    Text(
                      date,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // ===================================================
          // NOTICE MESSAGE
          // ===================================================

          Text(
            message,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}