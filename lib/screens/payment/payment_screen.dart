import 'package:flutter/material.dart';

// =============================================================
// PAYMENT STORAGE
// =============================================================
// Keeps payment history while the app is running.
// =============================================================

class PaymentStorage {
  static final List<PaymentRecord> payments = [
    PaymentRecord(
      month: 'July 2026',
      amount: '₹2,500',
      paymentDate: DateTime(2026, 7, 10),
    ),
  ];
}

// =============================================================
// PAYMENT RECORD
// =============================================================

class PaymentRecord {
  final String month;
  final String amount;
  final DateTime paymentDate;

  PaymentRecord({
    required this.month,
    required this.amount,
    required this.paymentDate,
  });
}

// =============================================================
// PAYMENT SCREEN
// =============================================================

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final Color purple = const Color(0xFF5125D8);

  bool showQr = false;

  // ===========================================================
  // MONTH NAMES
  // ===========================================================

  static const List<String> months = [
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

  // ===========================================================
  // FORMAT DATE
  // ===========================================================

  String formatDate(DateTime date) {
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  String monthYear(DateTime date) {
    return '${months[date.month - 1]} ${date.year}';
  }

  // ===========================================================
  // OPEN QR
  // ===========================================================

  void openQr() {
    setState(() {
      showQr = true;
    });
  }

  // ===========================================================
  // CANCEL PAYMENT
  // ===========================================================

  void cancelPayment() {
    setState(() {
      showQr = false;
    });
  }

  // ===========================================================
  // COMPLETE PAYMENT
  // ===========================================================

  void completePayment() {
    final DateTime now = DateTime.now();

    PaymentStorage.payments.insert(
      0,
      PaymentRecord(
        month: monthYear(now),
        amount: '₹2,500',
        paymentDate: now,
      ),
    );

    setState(() {
      showQr = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Payment successful!',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // ===========================================================
  // BUILD
  // ===========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F4FB),

      // =======================================================
      // APP BAR
      // =======================================================

      appBar: AppBar(
        backgroundColor: purple,
        elevation: 0,

        title: const Text(
          'Payments',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),

        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),

      // =======================================================
      // BODY
      // =======================================================

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          16,
          18,
          16,
          30,
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ==================================================
            // CURRENT BILL HEADER
            // ==================================================

            const Text(
              'Current Bill',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            // ==================================================
            // BILL CARD
            // ==================================================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF673AB7),
                    Color(0xFF5125D8),
                  ],
                ),

                borderRadius: BorderRadius.circular(22),

                boxShadow: [
                  BoxShadow(
                    color: purple.withOpacity(0.25),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  // BILL TOP ROW
                  Row(
                    children: [

                      Container(
                        width: 52,
                        height: 52,

                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.18),
                          shape: BoxShape.circle,
                        ),

                        child: const Icon(
                          Icons.account_balance_wallet,
                          color: Colors.white,
                          size: 27,
                        ),
                      ),

                      const SizedBox(width: 13),

                      const Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,

                          children: [

                            Text(
                              'Maintenance Bill',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: 4),

                            Text(
                              'Monthly maintenance',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // DUE BADGE
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),

                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.18),
                          borderRadius:
                              BorderRadius.circular(20),
                        ),

                        child: const Text(
                          'DUE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  // AMOUNT
                  const Text(
                    'Amount Due',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),

                  const SizedBox(height: 4),

                  const Text(
                    '₹2,500',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  // DUE DATE
                  Row(
                    children: const [

                      Icon(
                        Icons.calendar_today,
                        color: Colors.white70,
                        size: 16,
                      ),

                      SizedBox(width: 7),

                      Text(
                        'Due on 10 August 2026',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            // ==================================================
            // PAYMENT AREA
            // ==================================================

            if (showQr)
              _buildQrSection()
            else
              _buildPayNowSection(),

            const SizedBox(height: 28),

            // ==================================================
            // PAYMENT HISTORY
            // ==================================================

            Row(
              children: [

                const Expanded(
                  child: Text(
                    'Payment History',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),

                  decoration: BoxDecoration(
                    color: purple.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: Text(
                    '${PaymentStorage.payments.length} Payments',
                    style: TextStyle(
                      color: purple,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 13),

            // ==================================================
            // HISTORY LIST
            // ==================================================

            if (PaymentStorage.payments.isEmpty)

              _buildEmptyHistory()

            else

              ...PaymentStorage.payments.map(
                (payment) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      bottom: 12,
                    ),

                    child: PaymentHistoryCard(
                      month: payment.month,
                      amount: payment.amount,
                      date:
                          'Paid on: ${formatDate(payment.paymentDate)}',
                    ),
                  );
                },
              ),

            const SizedBox(height: 8),

            // ==================================================
            // PAYMENT INFORMATION
            // ==================================================

            const Text(
              'Payment Information',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            _buildInformationCard(),
          ],
        ),
      ),
    );
  }

  // ===========================================================
  // PAY NOW SECTION
  // ===========================================================

  Widget _buildPayNowSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 9,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          const Text(
            'Ready to pay?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          const Text(
            'Pay your monthly maintenance using UPI.',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            height: 54,

            child: ElevatedButton.icon(
              onPressed: openQr,

              icon: const Icon(
                Icons.qr_code_2,
                color: Colors.white,
                size: 25,
              ),

              label: const Text(
                'PAY NOW',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),

              style: ElevatedButton.styleFrom(
                backgroundColor: purple,
                foregroundColor: Colors.white,
                elevation: 0,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // QR SECTION
  // ===========================================================

  Widget _buildQrSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        children: [

          // QR TITLE
          Text(
            'Scan to Pay',
            style: TextStyle(
              color: purple,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          const Text(
            'Use any supported UPI app',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            '₹2,500',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 18),

          // QR CODE
          Container(
            width: 230,
            height: 230,
            padding: const EdgeInsets.all(10),

            decoration: BoxDecoration(
              color: Colors.white,

              border: Border.all(
                color: Colors.grey.shade300,
                width: 2,
              ),

              borderRadius: BorderRadius.circular(12),
            ),

            child: const SimpleQrCode(),
          ),

          const SizedBox(height: 14),

          const Text(
            'Scan this QR code using your UPI app',
            textAlign: TextAlign.center,

            style: TextStyle(
              color: Colors.grey,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 20),

          // I HAVE PAID
          SizedBox(
            width: double.infinity,
            height: 52,

            child: ElevatedButton(
              onPressed: completePayment,

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                elevation: 0,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),

              child: const Text(
                'I HAVE PAID',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // CANCEL
          SizedBox(
            width: double.infinity,
            height: 50,

            child: OutlinedButton(
              onPressed: cancelPayment,

              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.grey.shade700,

                side: BorderSide(
                  color: Colors.grey.shade300,
                  width: 1.5,
                ),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),

              child: const Text(
                'CANCEL',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // EMPTY HISTORY
  // ===========================================================

  Widget _buildEmptyHistory() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),

      child: Column(
        children: [

          Icon(
            Icons.receipt_long,
            size: 45,
            color: Colors.grey.shade400,
          ),

          const SizedBox(height: 10),

          const Text(
            'No payment history yet',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // PAYMENT INFORMATION CARD
  // ===========================================================

  Widget _buildInformationCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Column(
        children: [

          _infoRow(
            Icons.home,
            'Apartment','Flat A-203',
            Colors.deepPurple,
          ),

          const Divider(height: 22),

          _infoRow(
            Icons.receipt_long,
            'Payment Type',
            'Monthly Maintenance',
            Colors.blue,
          ),

          const Divider(height: 22),

          _infoRow(
            Icons.calendar_month,
            'Due Date',
            '10 August 2026',
            Colors.orange,
          ),

          const Divider(height: 22),

          _infoRow(
            Icons.payment,
            'Payment Method',
            'UPI',
            Colors.green,
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // INFORMATION ROW
  // ===========================================================

  Widget _infoRow(
    IconData icon,
    String title,
    String value,
    Color color,
  ) {
    return Row(
      children: [

        Container(
          width: 40,
          height: 40,

          decoration: BoxDecoration(
            color: color.withOpacity(0.10),
            borderRadius: BorderRadius.circular(12),
          ),

          child: Icon(
            icon,
            color: color,
            size: 21,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              Text(
                title,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),

              const SizedBox(height: 2),

              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// =============================================================
// PAYMENT HISTORY CARD
// =============================================================

class PaymentHistoryCard extends StatelessWidget {
  final String month;
  final String amount;
  final String date;

  const PaymentHistoryCard({
    super.key,
    required this.month,
    required this.amount,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),

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

          // CHECK ICON
          Container(
            width: 46,
            height: 46,

            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.10),
              shape: BoxShape.circle,
            ),

            child: const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 27,
            ),
          ),

          const SizedBox(width: 13),

          // DETAILS
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  month,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  date,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  'Maintenance Payment',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          // AMOUNT + PAID
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.end,

            children: [

              Text(
                amount,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 4,
                ),

                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(20),
                ),

                child: const Text(
                  'PAID',
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
    );
  }
}

// =============================================================
// SIMPLE QR CODE
// =============================================================
// NOTE:
// This is currently a visual/demo QR pattern.
// Later we can replace it with a real UPI QR code.
// =============================================================

class SimpleQrCode extends StatelessWidget {
  const SimpleQrCode({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,

      physics:
          const NeverScrollableScrollPhysics(),

      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 21,
      ),

      itemCount: 441,

      itemBuilder: (context, index) {
        final int row = index ~/ 21;
        final int column = index % 21;

        bool black = false;

        // TOP LEFT
        if (row < 7 && column < 7) {
          black = finderPattern(
            row,
            column,
          );
        }

        // TOP RIGHT
        else if (row < 7 && column >= 14) {
          black = finderPattern(
            row,
            column - 14,
          );
        }

        // BOTTOM LEFT
        else if (row >= 14 && column < 7) {
          black = finderPattern(
            row - 14,
            column,
          );
        }

        // OTHER CELLS
        else {
          black =
              ((row * 3 +
                          column * 5 +
                          row * column) %
                      7) <
                  3;
        }

        return Container(
          color: black
              ? Colors.black
              : Colors.white,
        );
      },
    );
  }

  // ===========================================================
  // QR FINDER PATTERN
  // ===========================================================

  static bool finderPattern(
    int row,
    int column,
  ) {
    // Outer square
    if (row == 0 ||
        row == 6 ||
        column == 0 ||
        column == 6) {
      return true;
    }

    // Inner square
    if (row >= 2 &&
        row <= 4 &&
        column >= 2 &&
        column <= 4) {
      return true;
    }

    return false;
  }
}