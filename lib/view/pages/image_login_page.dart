import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simpeg/data/admin_data.dart';
import 'package:simpeg/models/admin_model.dart';
import 'package:simpeg/provider/auth_provider.dart';
import 'package:simpeg/provider/steganograph_decrypt_provider.dart';
import 'package:simpeg/view/pages/image_register_page.dart';
import 'package:simpeg/view/pages/login_page.dart';
import 'package:simpeg/view/pages/main_page.dart';
import 'package:simpeg/view/widget/logo_top_widget.dart';
import 'package:simpeg/view/widget/top_title_widget.dart';

class ImageLoginPage extends StatefulWidget {
  const ImageLoginPage({super.key});

  @override
  State<ImageLoginPage> createState() => _ImageLoginPageState();
}

class _ImageLoginPageState extends State<ImageLoginPage> {
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
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return LoginPage();
                },
              ));
            },
            icon: Icon(Icons.arrow_back_ios_new)),
      ),
      body: Consumer<SteganographDecryptProvider>(
          builder: (context, provider, child) {
        return ListView(
          children: [
            LogoTopWidget(),
            TopTitleWidget(
              title: "Login",
              subTitle: "Login using image to continue use the app",
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.13),
              child: Card(
                color: Colors.grey,
                elevation: 8,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.18,
                  decoration: BoxDecoration(
                      image: provider.fileImage != null
                          ? DecorationImage(
                              image: FileImage(provider.fileImage!),
                              fit: BoxFit.cover)
                          : DecorationImage(
                              image: NetworkImage(
                                  'https://coffective.com/wp-content/uploads/2018/06/default-featured-image.png.jpg'),
                              fit: BoxFit.cover)),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () async {
                      if (await provider.takePickture()) {
                        print("Success");
                      } else {
                        print("Failed");
                      }
                    },
                    icon: Icon(
                      Icons.image,
                      color: Colors.black,
                    ))
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.018),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.15,
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
                            "Insert Key",
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
                      child: TextFormField(
                        controller: provider.etKeyDecypt,
                        maxLength: 4,
                        decoration: InputDecoration(
                            hintText: "Masukkan kunci",
                            fillColor: Colors.grey.shade300,
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black, strokeAlign: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)))),
                      ),
                    ))
                  ],
                ),
              ),
            ),
            Consumer<AuthProvider>(builder: (context, authprov, child) {
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.1),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: provider.isLoading
                      ? ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                  Color.fromARGB(255, 60, 129, 249))),
                          onPressed: () {
                            print("Loading");
                          },
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ))
                      : ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                  Color.fromARGB(255, 60, 129, 249))),
                          onPressed: () async {
                            if (await provider.unCloakMessageNew()) {
                              AdminModel? admin = await AdminData()
                                  .loginUser(provider.emailLogin, '', 2);
                              if (admin == null) {
                                Fluttertoast.showToast(
                                    msg: "User Tidak Terdaftar");
                              } else {
                                authprov.updateUserInformation(admin);
                                preferences.setString(
                              'token', authprov.adminModel!.token);
                              preferences.setString(
                              'id', admin.idAdmin.toString());
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(
                                  builder: (context) {
                                    return MainPage();
                                  },
                                ));
                              }
                            } else {
                              Fluttertoast.showToast(msg: "Failed");
                            }
                          },
                          child: Text(
                            "Login",
                            style: GoogleFonts.poppins(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          )),
                ),
              );
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't Have Image ?",
                  style: GoogleFonts.nunito(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return ImageRegisterPage();
                        },
                      ));
                    },
                    child: Text(
                      "Register Image",
                      style: GoogleFonts.nunito(
                          fontSize: 18,
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.w700),
                    ))
              ],
            )
          ],
        );
      }),
    );
  }
}
