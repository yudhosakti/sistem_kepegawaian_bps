import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simpeg/provider/steganograph_encrypt_provider.dart';
import 'package:simpeg/view/pages/image_login_page.dart';
import 'package:simpeg/view/widget/logo_top_widget.dart';
import 'package:simpeg/view/widget/top_title_widget.dart';

class ImageRegisterPage extends StatelessWidget {
  const ImageRegisterPage({super.key});

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
                  return ImageLoginPage();
                },
              ));
            },
            icon: Icon(Icons.arrow_back_ios_new)),
      ),
      body: Consumer<SteganographEncryptProvider>(
          builder: (context, provider, child) {
        return ListView(
          children: [
            LogoTopWidget(),
            TopTitleWidget(
              title: "Register",
              subTitle: "Register your image to use login auth",
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
                        print("Canceled");
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
                            "Insert Email",
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
                        controller: provider.etEmail,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: "Masukkan Email",
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
            Padding(
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
                          if (await provider.encryptionProccessEmail()) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Enkripsi Success"),
                                  content: Text(
                                      "Proses enkripsi telah selesai, silahkan cek email untuk mendapatkan kunci dari gambar"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "Ok",
                                          style: GoogleFonts.poppins(
                                              color: Colors.blueAccent),
                                        ))
                                  ],
                                );
                              },
                            );
                          } else {
                            print("Failed");
                            Fluttertoast.showToast(msg: provider.errorMessage);
                          }
                        },
                        child: Text(
                          "Register Image",
                          style: GoogleFonts.poppins(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        )),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already Have Image ?",
                  style: GoogleFonts.nunito(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return ImageLoginPage();
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
        );
      }),
    );
  }
}
