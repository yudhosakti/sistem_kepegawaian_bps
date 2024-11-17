import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simpeg/models/admin_model.dart';

class DetailUserPage extends StatelessWidget {
  final AdminModel adminModel;
  const DetailUserPage({super.key, required this.adminModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail User"),
      ),
      body: ListView(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.22,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                    image: adminModel.avatar == ''
                        ? DecorationImage(
                            opacity: 0.6,
                            image: AssetImage('assets/default_profile.jpg'),
                          )
                        : DecorationImage(
                            image: NetworkImage(adminModel.avatar),
                            fit: BoxFit.fill),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          UserDetailComponentWidget(
            title: "Username",
            value: adminModel.username,
          ),
          UserDetailComponentWidget(
            title: "Email",
            value: adminModel.email,
          ),
          UserDetailComponentWidget(
            title: "Role",
            value: adminModel.role,
          ),
          UserDetailComponentWidget(
            title: "Last Login",
            value: adminModel.lastLogin,
          ),
        ],
      ),
    );
  }
}

class UserDetailComponentWidget extends StatelessWidget {
  final String title;
  final String value;
  const UserDetailComponentWidget(
      {super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.01,
          right: MediaQuery.of(context).size.width * 0.3),
      child: Card(
        color: Colors.white,
        elevation: 5,
        margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.height * 0.01,
            bottom: MediaQuery.of(context).size.height * 0.01),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.08,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.01),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.04,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${title} : ",
                      style: GoogleFonts.poppins(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      value,
                      style: GoogleFonts.poppins(color: Colors.black),
                    ),
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
