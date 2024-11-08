import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simpeg/provider/auth_provider.dart';
import 'package:simpeg/view/pages/image_login_page.dart';
import 'package:simpeg/view/pages/main_page.dart';
import 'package:simpeg/view/pages/onboarding_page.dart';
import 'package:simpeg/view/pages/register_page.dart';
import 'package:simpeg/view/widget/logo_top_widget.dart';
import 'package:simpeg/view/widget/text_email_form_widget.dart';
import 'package:simpeg/view/widget/top_title_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late SharedPreferences preferences;

  @override
  void initState() {
    initialSharePref();
    super.initState();
  }

  Future<void> initialSharePref() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OnBoardingPage(),
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
            title: "Login",
            subTitle: "Login to continue use the app",
          ),
          Consumer<AuthProvider>(builder: (context, provider, child) {
            return TextEmailFormWidget(
              code: 0,
              iconValue: false,
              editingController: provider.etEmailLogin,
              hint: "Enter Your Email",
              isInVisible: false,
              isPassword: false,
              title: "Email",
            );
          }),
          Consumer<AuthProvider>(builder: (context, provider, child) {
            return TextEmailFormWidget(
              code: 1,
              iconValue: provider.passwordLogin,
              editingController: provider.etPasswordLogin,
              hint: "Enter Your Password",
              isInVisible: true,
              isPassword: true,
              title: "Password",
            );
          }),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.06,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot Password ?",
                      style: GoogleFonts.nunito(
                          color: Colors.blueAccent,
                          fontSize: 19,
                          fontWeight: FontWeight.w700),
                    ))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.03,
                vertical: MediaQuery.of(context).size.height * 0.01),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.08,
              child:
                  Consumer<AuthProvider>(builder: (context, provider, child) {
                return ElevatedButton(
                    style: ButtonStyle(
                        elevation: WidgetStatePropertyAll(5),
                        backgroundColor: WidgetStatePropertyAll(
                            Color.fromARGB(255, 60, 129, 249))),
                    onPressed: () async {
                      if (provider.isLoading) {
                        Fluttertoast.showToast(msg: "Loading");
                      } else {
                        if (await provider.loginUser()) {
                          preferences.setString(
                              'token', provider.adminModel!.token);
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return MainPage();
                            },
                          ));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.black,
                              content: Text(
                                provider.errorMessage,
                                style: GoogleFonts.nunito(
                                  color: Colors.white,
                                ),
                              )));
                        }
                      }
                    },
                    child: provider.isLoading
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            "Login",
                            style: GoogleFonts.nunito(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ));
              }),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.06,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  height: 1,
                  color: Colors.black,
                ),
                Text(
                  "Or Login With",
                  style: GoogleFonts.nunito(
                      color: Colors.grey, fontWeight: FontWeight.w700),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  height: 1,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.06,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.15,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return ImageLoginPage();
                          },
                        ));
                      },
                      icon: Icon(
                        size: 36,
                        Icons.fingerprint,
                        color: Colors.black,
                      )),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't Have Account ?",
                style: GoogleFonts.nunito(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return RegisterPage();
                      },
                    ));
                  },
                  child: Text(
                    "Register Now",
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
