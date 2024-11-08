import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LogPage extends StatelessWidget {
  const LogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Log Activity",style: GoogleFonts.poppins(
          color: Colors.white,
          fontWeight: FontWeight.w500
        ),),
      ),
    );
  }
}