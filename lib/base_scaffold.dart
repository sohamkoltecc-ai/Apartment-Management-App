import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BaseScaffold extends StatelessWidget {
  final String title;
  final Widget drawer;
  final Widget body;
  final List<Widget>? actions;
  const BaseScaffold({
    Key? key,
    required this.title,
    required this.drawer,
    required this.body,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          title,
          style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: actions,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      drawer: drawer,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE0EAFC), Color(0xFFCFDEF3)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: body,
      ),
    );
  }
}
