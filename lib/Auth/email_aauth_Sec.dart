import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_apart/Auth/otp_Auth_Sec.dart';

class EmailA extends StatefulWidget {
  const EmailA({super.key});

  @override
  State<EmailA> createState() => _EmailAState();
}

class _EmailAState extends State<EmailA> {
  final TextEditingController _emailController = TextEditingController();

  Future<void> sendOtp() async {
    String email = _emailController.text.trim();

    if (email.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter your email");
      return;
    }

    try {
      EmailAuth emailAuth = EmailAuth(sessionName: "My Apart");

      bool result = await emailAuth.sendOtp(recipientMail: email, otpLength: 6);

      if (result) {
        Fluttertoast.showToast(msg: "OTP sent successfully");

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OtpSec(email: email)),
        );
      } else {
        Fluttertoast.showToast(msg: "Please resend OTP");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error sending OTP");

      debugPrint("OTP Error: $e");
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset("assets/images/Email1.png", fit: BoxFit.cover),

              const SizedBox(height: 30),

              const Text(
                "Good to see you again!",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),

              const SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 40,
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: "Enter Email",
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Color(0xffF9A826),
                        ),
                        labelStyle: TextStyle(color: Colors.blueGrey),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 3,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: sendOtp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            255,
                            241,
                            175,
                            68,
                          ),
                        ),
                        child: const Text(
                          "Send OTP",
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
