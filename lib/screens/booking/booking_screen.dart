import 'package:flutter/material.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final Color purple = const Color(0xFF5125D8);

  String? selectedFacility;
  DateTime? selectedDate;
  String? selectedTime;

  final List<Map<String, String>> bookings = [];

  final List<Map<String, dynamic>> facilities = [
    {
      'name': 'Swimming Pool',
      'icon': Icons.pool,
      'color': Colors.blue,
    },
    {
      'name': 'Gym',
      'icon': Icons.fitness_center,
      'color': Colors.orange,
    },
    {
      'name': 'Badminton Court',
      'icon': Icons.sports_tennis,
      'color': Colors.green,
    },
    {
      'name': 'Community Hall',
      'icon': Icons.groups,
      'color': Colors.purple,
    },
  ];

  final List<String> timeSlots = [
    '9:00 AM - 10:00 AM',
    '10:00 AM - 11:00 AM',
    '11:00 AM - 12:00 PM',
    '4:00 PM - 5:00 PM',
    '5:00 PM - 6:00 PM',
    '6:00 PM - 7:00 PM',
  ];

  // =========================================================
  // SELECT DATE
  // =========================================================

  Future<void> selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 90),
      ),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  // =========================================================
  // FORMAT DATE
  // =========================================================

  String formatDate(DateTime date) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  // =========================================================
  // BOOK FACILITY
  // =========================================================

  void bookFacility() {
    if (selectedFacility == null ||
        selectedDate == null ||
        selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please select facility, date and time.',
          ),
        ),
      );

      return;
    }

    setState(() {
      bookings.insert(
        0,
        {
          'facility': selectedFacility!,
          'date': formatDate(selectedDate!),
          'time': selectedTime!,
        },
      );

      selectedFacility = null;
      selectedDate = null;
      selectedTime = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Facility booked successfully!',
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  // =========================================================
  // CANCEL BOOKING
  // =========================================================

  void cancelBooking(int index) {
    setState(() {
      bookings.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Booking cancelled.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F5FF),

      // =====================================================
      // APP BAR
      // =====================================================

      appBar: AppBar(
        backgroundColor: purple,
        elevation: 0,

        title: const Text(
          'Booking',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),

        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),

      // =====================================================
      // BODY
      // =====================================================

      body: ListView(
        padding: const EdgeInsets.all(16),

        children: [

          const Text(
            'Facility Booking',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            'Book apartment facilities easily',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 22),

          // =================================================
          // FACILITIES
          // =================================================

          const Text(
            'Select Facility',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          ...facilities.map(
            (facility) {
              final bool selected =
                  selectedFacility == facility['name'];

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedFacility = facility['name'];
                  });
                },

                child: Container(
                  margin: const EdgeInsets.only(
                    bottom: 12,
                  ),

                  padding: const EdgeInsets.all(15),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),

                    border: Border.all(
                      color: selected
                          ? purple
                          : Colors.transparent,
                      width: 2,
                    ),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),

                  child: Row(
                    children: [

                      Container(
                        width: 52,
                        height: 52,

                        decoration: BoxDecoration(
                          color: facility['color']
                              .withOpacity(0.12),
                          shape: BoxShape.circle,
                        ),

                        child: Icon(
                          facility['icon'],
                          color: facility['color'],
                          size: 27,
                        ),
                      ),

                      const SizedBox(width: 15),

                      Expanded(
                        child: Text(
                          facility['name'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      Icon(
                        selected
                            ? Icons.check_circle
                            : Icons.radio_button_unchecked,
                        color: selected
                            ? purple
                            : Colors.grey,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 10),

          // =================================================
          // DATE
          // =================================================

          const Text(
            'Select Date',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          GestureDetector(
            onTap: selectDate,

            child: Container(
              padding: const EdgeInsets.all(17),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 7,
                  ),
                ],
              ),

              child: Row(
                children: [

                  Icon(
                    Icons.calendar_month,
                    color: purple,
                    size: 28,
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Text(
                      selectedDate == null
                          ? 'Choose booking date'
                          : formatDate(selectedDate!),
                      style: TextStyle(
                        color: selectedDate == null
                            ? Colors.grey
                            : Colors.black,
                        fontSize: 15,
                        fontWeight: selectedDate == null
                            ? FontWeight.normal
                            : FontWeight.bold,
                      ),
                    ),
                  ),

                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 17,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 22),

          // =================================================
          // TIME
          // =================================================

          const Text(
            'Select Time',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          Wrap(
            spacing: 10,
            runSpacing: 10,

            children: timeSlots.map(
              (time) {
                final bool selected =
                    selectedTime == time;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTime = time;
                    });
                  },

                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 13,
                      vertical: 12,
                    ),

                    decoration: BoxDecoration(
                      color: selected
                          ? purple
                          : Colors.white,

                      borderRadius:
                          BorderRadius.circular(12),

                      border: Border.all(
                        color: selected
                            ? purple
                            : Colors.grey.shade300,
                      ),
                    ),

                    child: Text(
                      time,
                      style: TextStyle(
                        color: selected
                            ? Colors.white
                            : Colors.black87,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
            ).toList(),
          ),

          const SizedBox(height: 24),

          // =================================================
          // BOOK BUTTON
          // =================================================

          SizedBox(
            width: double.infinity,
            height: 54,

            child: ElevatedButton(
              onPressed: bookFacility,

              style: ElevatedButton.styleFrom(
                backgroundColor: purple,
                foregroundColor: Colors.white,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),

              child: const Text(
                'BOOK NOW',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),

          // =================================================
          // MY BOOKINGS
          // =================================================

          const Text(
            'My Bookings',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 14),

          if (bookings.isEmpty)

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),

              child: const Column(
                children: [

                  Icon(
                    Icons.event_available,
                    size: 45,
                    color: Colors.grey,
                  ),

                  SizedBox(height: 10),

                  Text(
                    'No bookings yet',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            )

          else

            ...bookings.asMap().entries.map(
              (entry) {
                final int index = entry.key;
                final booking = entry.value;

                return Container(
                  margin: const EdgeInsets.only(
                    bottom: 12,
                  ),

                  padding: const EdgeInsets.all(16),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(17),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 7,
                      ),
                    ],
                  ),

                  child: Row(
                    children: [

                      Container(
                        width: 48,
                        height: 48,

                        decoration: BoxDecoration(
                          color: purple.withOpacity(0.10),
                          shape: BoxShape.circle,
                        ),

                        child: Icon(
                          Icons.event_available,
                          color: purple,
                        ),
                      ),

                      const SizedBox(width: 13),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,

                          children: [

                            Text(
                              booking['facility']!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 5),

                            Text(
                              booking['date']!,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),

                            const SizedBox(height: 3),

                            Text(
                              booking['time']!,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),

                      TextButton(
                        onPressed: () {
                          cancelBooking(index);
                        },

                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}