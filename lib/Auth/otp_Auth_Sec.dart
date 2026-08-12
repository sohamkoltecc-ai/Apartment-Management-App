import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_text_field/otp_text_field.dart';

class OtpSec extends StatelessWidget {
  final String email;

  OtpSec({super.key, required this.email});

  final EmailAuth emailAuth = EmailAuth(sessionName: "My Apart");

  final OtpFieldController _otpController = OtpFieldController();

  Future<void> verifyOTP(BuildContext context) async {
    try {
      bool result = await emailAuth.validateOtp(
        recipientMail: email,
        userOtp: _otpController.toString(),
      );

      if (result) {
        print("OTP verified");

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("OTP Verified Successfully")),
        );
      } else {
        print("Invalid OTP");

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Invalid OTP")));
      }
    } catch (e) {
      print("OTP verification error: $e");

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("OTP verification failed")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "CO",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontSize: 80.0,
                color: const Color(0xffF9A826),
              ),
            ),

            Text(
              "DE",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontSize: 80.0,
                color: const Color(0xffF9A826),
              ),
            ),

            Text(
              "VERIFICATION",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
                fontSize: 16.0,
              ),
            ),

            const SizedBox(height: 40),

            Text(
              "Enter the verification code sent at\n$email",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20.0, color: Colors.grey),
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 100,
              width: 250,
              child: OTPTextField(
                controller: _otpController,
                length: 6,
                otpFieldStyle: OtpFieldStyle(backgroundColor: Colors.grey),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  verifyOTP(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 241, 175, 68),
                ),
                child: const Text(
                  "Next",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
              ),
            ),

            const SizedBox(height: 160),
          ],
        ),
      ),
    );
  }
}
