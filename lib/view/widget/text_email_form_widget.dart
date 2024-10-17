import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simpeg/provider/auth_provider.dart';


class TextEmailFormWidget extends StatelessWidget {
  final String title;
  final String hint;
  final int code;
  final bool iconValue;
  final TextEditingController editingController;
  final bool isPassword;
  final bool isInVisible;
  const TextEmailFormWidget(
      {super.key,
      required this.isPassword,
      required this.iconValue,
      required this.code,
      required this.hint,
      required this.isInVisible,
      required this.editingController,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.018),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.13,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.05,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.005),
                  child: Text(
                    title,
                    style: GoogleFonts.nunito(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 20),
                  ),
                ),
              ),
            ),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              child: TextFormField(
                controller: editingController,
                obscureText: iconValue,
                style: GoogleFonts.nunito(color: Colors.black, fontSize: 18),
                decoration: InputDecoration(
                    suffixIcon: isPassword
                        ? Consumer<AuthProvider>(
                            builder: (context, provider, child) {
                            return IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  provider.changeObsCure(code);
                                },
                                icon: Icon(
                                  Icons.remove_red_eye_sharp,
                                  color: Colors.black,
                                ));
                          })
                        : null,
                    hintText: hint,
                    contentPadding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.025,
                        horizontal: MediaQuery.of(context).size.width * 0.025),
                    border: InputBorder.none),
              ),
            ))
          ],
        ),
      ),
    );
  }
}