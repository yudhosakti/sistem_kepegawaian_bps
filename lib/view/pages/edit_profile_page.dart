import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simpeg/provider/auth_provider.dart';
import 'package:simpeg/provider/edit_user_provider.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: Text(
          "Edit Profile",
          style: GoogleFonts.poppins(color: Colors.white),
        ),
      ),
      body: Consumer<EditUserProvider>(builder: (context, provider, child) {
        provider.initialData(context.read<AuthProvider>().adminModel!.username,
            context.read<AuthProvider>().adminModel!.email);
        return ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height,
                    decoration: provider.fileImage == null
                        ? BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
                            image: context
                                        .read<AuthProvider>()
                                        .adminModel!
                                        .avatar !=
                                    ''
                                ? DecorationImage(
                                    image: NetworkImage(context
                                        .read<AuthProvider>()
                                        .adminModel!
                                        .avatar),
                                    fit: BoxFit.fill)
                                : DecorationImage(
                                    image: AssetImage(
                                        'assets/default_profile.jpg')))
                        : BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: FileImage(provider.fileImage!))),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          right: MediaQuery.of(context).size.width * 0.07,
                          child: Card(
                            elevation: 5,
                            color: Colors.white,
                            shape: CircleBorder(),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.1,
                              height: MediaQuery.of(context).size.height * 0.05,
                              decoration: BoxDecoration(),
                              child: IconButton(
                                  onPressed: () async {
                                    if (await provider.takePickture()) {
                                      print("Success");
                                    } else {
                                      print("Canceled");
                                    }
                                  },
                                  icon: Icon(Icons.image)),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.035,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.1),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.11,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Username",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Expanded(
                        child: Container(
                      child: TextFormField(
                        controller: provider.etUsername,
                        decoration: InputDecoration(
                            hintText: "Masukkan Username",
                            fillColor: Color.fromRGBO(188, 191, 227, 0.3),
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(24)))),
                      ),
                    ))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.1),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.11,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Expanded(
                        child: Container(
                      child: TextFormField(
                        controller: provider.etEmail,
                        decoration: InputDecoration(
                            hintText: "Masukkan Email",
                            fillColor: Color.fromRGBO(188, 191, 227, 0.3),
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(24)))),
                      ),
                    ))
                  ],
                ),
              ),
            )
          ],
        );
      }),
      bottomSheet: Row(
        children: [
          Consumer<EditUserProvider>(builder: (context, provider, child) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.08,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                        backgroundColor:
                            WidgetStatePropertyAll(Colors.blueAccent)),
                    onPressed: () async {
                      if (provider.isLoading) {
                        print("Loading");
                      } else {
                        if (await provider.updateProfile(
                            context.read<AuthProvider>().adminModel!.idAdmin)) {
                          context
                              .read<AuthProvider>()
                              .updateUserInformation(provider.modelAdmin!);
                          Fluttertoast.showToast(msg: "Update Profile Success");
                        } else {
                          Fluttertoast.showToast(msg: "Failed Update");
                        }
                      }
                    },
                    child: provider.isLoading
                        ? CircularProgressIndicator()
                        : Text(
                            "Save Profile",
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          )),
              ),
            );
          }),
        ],
      ),
    );
  }
}
