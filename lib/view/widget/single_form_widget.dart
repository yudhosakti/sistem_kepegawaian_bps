import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class SingleFormWidget extends StatelessWidget {
  final String title;
  final String hintText;
  final bool isEditable;
  final TextEditingController editingController;
  const SingleFormWidget(
      {super.key,
      required this.editingController,
      required this.hintText,
      required this.isEditable,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.01),
      child: Container(
        margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.002,
            bottom: MediaQuery.of(context).size.height * 0.002),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.1,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.04,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: GoogleFonts.nunito(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Expanded(
                child: Container(
              child: Padding(
                padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.3),
                child: TextFormField(
                  style: GoogleFonts.nunito(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 17),
                  enabled: isEditable,
                  controller: editingController,
                  decoration: InputDecoration(
                      hintText: hintText,
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)))),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
