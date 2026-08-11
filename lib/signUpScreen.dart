import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_apart/admin_login.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController emailEditController = TextEditingController();

  final TextEditingController passEditController = TextEditingController();

  final TextEditingController nameEditController = TextEditingController();

  final TextEditingController flatEditController = TextEditingController();

  final TextEditingController vehicleEditController = TextEditingController();

  bool isLoading = false;

  final CollectionReference secretaryCollection = FirebaseFirestore.instance
      .collection("Secretary");

  @override
  void dispose() {
    emailEditController.dispose();
    passEditController.dispose();
    nameEditController.dispose();
    flatEditController.dispose();
    vehicleEditController.dispose();
    super.dispose();
  }

  Future<void> addMember() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    // Ensure an admin is logged in before creating a new member
    final User? adminUser = FirebaseAuth.instance.currentUser;
    if (adminUser == null) {
      Fluttertoast.showToast(msg: "❌ Admin is not logged in – please log in first.");
      // Navigate back to admin login screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => admin_login()),
      );
      return;
    }
    // Save admin UID (used for Firestore writes)
    final String adminUid = adminUser.uid;

    final String email = emailEditController.text.trim();

    final String password = passEditController.text.trim();

    final String name = nameEditController.text.trim();

    final String flatNumber = flatEditController.text.trim();

    final String vehicleNumber = vehicleEditController.text.trim();

    setState(() {
      isLoading = true;
    });

    try {
      // Create new member account
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      final User? newMember = userCredential.user;

      if (newMember == null) {
        throw Exception("Member account was not created");
      }

      // This is the NEW MEMBER UID
      final String memberUid = newMember.uid;

      // Save member information in Firestore
      await secretaryCollection
          .doc(adminUid)
          .collection("Members")
          .doc(memberUid)
          .set({
            "Name": name,
            "Email": email,
            "Flat Number": flatNumber,
            "Number of vehicles": vehicleNumber,
            "groups": [],
            "userUid": memberUid,
            "AdminUid": adminUid,
          });

      Fluttertoast.showToast(msg: "Member added Successfully");

      // New member is currently logged in.
      // Sign out before returning to admin login.
      await FirebaseAuth.instance.signOut();

      if (!mounted) return;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => admin_login()),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      // Friendly error messages for common FirebaseAuth errors
      const errorMap = {
        "email-already-in-use": "📧 This email is already registered.",
        "invalid-email": "✉️ Invalid email address.",
        "weak-password": "🔐 Password must be at least 8 characters.",
        "network-request-failed": "🌐 No internet – check your connection.",
      };
      final friendlyMsg = errorMap[e.code] ?? "❌ Registration failed (${e.code}).";
      Fluttertoast.showToast(msg: friendlyMsg);
      debugPrint("Firebase Auth Error: ${e.code}");
    } catch (e) {
      Fluttertoast.showToast(msg: "❌ Unexpected registration error");
      debugPrint("Registration Error: $e");
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 247, 174, 57),
          title: const Text(
            "Add New Member",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),

        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                Image.asset("assets/images/login.png", fit: BoxFit.cover),

                const SizedBox(height: 10),

                const Text(
                  "Get On Board!",
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // NAME
                      TextFormField(
                        controller: nameEditController,
                        decoration: const InputDecoration(
                          labelText: "Name",
                          prefixIcon: Icon(
                            Icons.person_outline_rounded,
                            color: Color(0xffF9A826),
                          ),
                          border: OutlineInputBorder(),
                          labelStyle: TextStyle(color: Colors.blueGrey),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 3,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Name cannot be empty";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      // EMAIL
                      TextFormField(
                        controller: emailEditController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: "Email",
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: Color(0xffF9A826),
                          ),
                          border: OutlineInputBorder(),
                          labelStyle: TextStyle(color: Colors.blueGrey),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 3,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Email cannot be empty";
                          }

                          if (!value.contains("@")) {
                            return "Enter a valid email";
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      // PASSWORD
                      TextFormField(
                        controller: passEditController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: "Create Password",
                          prefixIcon: Icon(
                            Icons.fingerprint_outlined,
                            color: Color(0xffF9A826),
                          ),
                          border: OutlineInputBorder(),
                          labelStyle: TextStyle(color: Colors.blueGrey),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 3,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password cannot be empty";
                          }

                          if (value.length < 8) {
                            return "Password length must be 8 or more";
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      // FLAT NUMBER
                      TextFormField(
                        controller: flatEditController,
                        decoration: const InputDecoration(
                          labelText: "Flat Number",
                          prefixIcon: Icon(
                            Icons.house_rounded,
                            color: Color(0xffF9A826),
                          ),
                          border: OutlineInputBorder(),
                          labelStyle: TextStyle(color: Colors.blueGrey),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 3,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Flat cannot be empty";
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      // VEHICLE
                      TextFormField(
                        controller: vehicleEditController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "Number of Vehicles",
                          prefixIcon: Icon(
                            Icons.car_crash_outlined,
                            color: Color(0xffF9A826),
                          ),
                          border: OutlineInputBorder(),
                          labelStyle: TextStyle(color: Colors.blueGrey),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 3,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Vehicle cannot be empty";
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 25),

                      // BUTTON
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : addMember,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              241,
                              175,
                              68,
                            ),
                          ),
                          child: isLoading
                              ? const SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 3,
                                  ),
                                )
                              : const Text(
                                  "Add Member",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
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
      ),
    );
  }
}
