import 'package:apartmentapp/Pages/home_page.dart';
import 'package:flutter/material.dart';

/* Main Loop  */
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /* Entry Point */
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomePage()
    );
  }
}

