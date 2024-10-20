import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simpeg/provider/auth_provider.dart';
import 'package:simpeg/view/pages/login_page.dart';
import 'package:simpeg/view/pages/onboarding_page.dart';
import 'package:simpeg/view/widget/logo_top_widget.dart';
import 'package:simpeg/view/widget/text_email_form_widget.dart';
import 'package:simpeg/view/widget/top_title_widget.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return OnBoardingPage();
                },
              ));
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      body: ListView(
        children: [
          LogoTopWidget(),
          TopTitleWidget(
            title: "Register",
            subTitle: "Enter your personal information",
          ),
          Consumer<AuthProvider>(builder: (context, provider, child) {
            return TextEmailFormWidget(
              code: 0,
              iconValue: false,
              editingController: provider.etUsernameRegister,
              hint: "Enter Your Name",
              isInVisible: false,
              isPassword: false,
              title: "Username",
            );
          }),
          Consumer<AuthProvider>(builder: (context, provider, child) {
            return TextEmailFormWidget(
              code: 0,
              iconValue: false,
              editingController: provider.etEmailRegister,
              hint: "Enter Your Email",
              isInVisible: false,
              isPassword: false,
              title: "Email",
            );
          }),
          Consumer<AuthProvider>(builder: (context, provider, child) {
            return TextEmailFormWidget(
              code: 2,
              iconValue: provider.passwordRegister,
              editingController: provider.etPasswordRegister,
              hint: "Enter Password",
              isInVisible: true,
              isPassword: true,
              title: "Password",
            );
          }),
          Consumer<AuthProvider>(builder: (context, provider, child) {
            return TextEmailFormWidget(
              code: 3,
              iconValue: provider.passwordConfirmRegister,
              editingController: provider.etConfirmPasswordRegister,
              hint: "Enter Confirm Password",
              isInVisible: true,
              isPassword: true,
              title: "Confirm Password",
            );
          }),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.06,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.04),
              child:
                  Consumer<AuthProvider>(builder: (context, provider, child) {
                return ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                            Color.fromARGB(255, 60, 129, 249))),
                    onPressed: () async {
                      if (await provider.registerUser()) {
                        Fluttertoast.showToast(msg: "Register Success");
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return LoginPage();
                          },
                        ));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.black,
                            content: Text(provider.errorMessage)));
                      }
                    },
                    child: provider.isLoading
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            "Register",
                            style: GoogleFonts.nunito(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 20),
                          ));
              }),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already Have Account ?",
                style: GoogleFonts.nunito(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return LoginPage();
                      },
                    ));
                  },
                  child: Text(
                    "Login Now",
                    style: GoogleFonts.nunito(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w700),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
