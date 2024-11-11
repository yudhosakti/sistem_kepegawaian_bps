import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simpeg/models/admin_model.dart';
import 'package:simpeg/provider/auth_provider.dart';
import 'package:simpeg/view/pages/edit_profile_page.dart';
import 'package:simpeg/view/pages/login_page.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  late SharedPreferences preferences;

  @override
  void initState()  {
    initialSharedPref();
    super.initState();
  }

  Future<void> initialSharedPref() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    AdminModel adminModel = context.read<AuthProvider>().adminModel!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(121, 102, 255, 1),
        title: Text(
          "Profile Information",
          style: GoogleFonts.mulish(
              color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.02),
            child: Card(
              color: Color.fromRGBO(121, 102, 255, 1),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.28,
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: MediaQuery.of(context).size.height * 0.1,
                            decoration: BoxDecoration(
                                image: adminModel.avatar == ''
                                    ? DecorationImage(
                                        image: AssetImage(
                                            'assets/default_profile.jpg'))
                                    : DecorationImage(
                                        image: NetworkImage(adminModel.avatar),
                                        fit: BoxFit.fill),
                                color: Colors.grey,
                                shape: BoxShape.circle),
                          ),
                          Text(
                            adminModel.username,
                            style: GoogleFonts.mulish(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            adminModel.email,
                            style: GoogleFonts.mulish(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                      Colors.blueAccent)),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return EditProfilePage();
                                  },
                                ));
                              },
                              child: Text(
                                "Edit Profile",
                                style: GoogleFonts.mulish(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              )),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.03,
                          ),
                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStatePropertyAll(Colors.redAccent)),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(
                                        "Logout Confirmation",
                                        style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      content: Text(
                                        "Apakah anda yakin ingin keluar dari aplikasi ? ",
                                        style: GoogleFonts.poppins(
                                            color: Colors.black, fontSize: 16),
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "Cancel",
                                              style: GoogleFonts.poppins(
                                                  color: Colors.blueAccent),
                                            )),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              context
                                                  .read<AuthProvider>()
                                                  .resetUser();
                                              preferences.setString(
                                                  'token', '');
                                              preferences.setString(
                                                  'id', '');
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        LoginPage(),
                                                  ));
                                            },
                                            child: Text(
                                              "Ok",
                                              style: GoogleFonts.poppins(
                                                  color: Colors.redAccent),
                                            ))
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Text(
                                "Logout",
                                style: GoogleFonts.mulish(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ))
                        ],
                      ),
                    ))
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.02),
            child: Card(
              color: Color.fromRGBO(137, 214, 195, 1),
              elevation: 5,
              child: Container(
                width: MediaQuery.of(context).size.width,
                constraints:
                    BoxConstraints(maxHeight: double.infinity, minHeight: 0.1),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.04,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 3),
                          child: Text(
                            "User Information",
                            style: GoogleFonts.mulish(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    ProfileUserWidget(
                        icons: Icons.person,
                        title: "Username",
                        value: adminModel.username),
                    ProfileUserWidget(
                      icons: Icons.email,
                      title: "Email",
                      value: adminModel.email,
                    ),
                    ProfileUserWidget(
                      icons: Icons.security,
                      title: "Role",
                      value: adminModel.role,
                    ),
                    ProfileUserWidget(
                      icons: Icons.timelapse,
                      title: "Last Login",
                      value: adminModel.lastLogin,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ProfileUserWidget extends StatelessWidget {
  final String title;
  final String value;
  final IconData icons;
  const ProfileUserWidget(
      {super.key,
      required this.icons,
      required this.title,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.01,
          vertical: MediaQuery.of(context).size.height * 0.005),
      child: Card(
        color: Colors.blueAccent,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.08,
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.1,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(),
                child: Center(
                  child: Icon(
                    icons,
                    size: 32,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.mulish(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.005,
                    ),
                    Text(
                      value,
                      style: GoogleFonts.mulish(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
