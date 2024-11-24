import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simpeg/models/admin_model.dart';
import 'package:simpeg/provider/auth_provider.dart';
import 'package:simpeg/provider/detail_user_provider.dart';
import 'package:simpeg/view/widget/information_user_widget.dart';

class DetailUserPage extends StatelessWidget {
  final AdminModel adminModel;
  const DetailUserPage({super.key, required this.adminModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail User"),
      ),
      body: Builder(
        builder: (context) {
          context.read<DetailUserProvider>().setAdminModel(adminModel);
          return Consumer<DetailUserProvider>(builder: (context, provider, child) {
            return ListView(
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
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.01,
                      right: MediaQuery.of(context).size.width * 0.28),
                  child: InformationUserWidget(
                    dataAdmin: provider.adminModel!,
                    code: 1,
                    isEditable:
                        context.read<AuthProvider>().adminModel!.role == 'Admin'
                            ? true
                            : false,
                    data: provider.adminModel!.username,
                    title: "Username",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.01,
                      right: MediaQuery.of(context).size.width * 0.28),
                  child: InformationUserWidget(
                    dataAdmin: provider.adminModel!,
                    code: 2,
                    isEditable:
                        context.read<AuthProvider>().adminModel!.role == 'Admin'
                            ? true
                            : false,
                    data: provider.adminModel!.email,
                    title: "Email",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.01,
                      right: MediaQuery.of(context).size.width * 0.28),
                  child: InformationUserWidget(
                    dataAdmin: provider.adminModel!,
                    code: 3,
                    isEditable:
                        context.read<AuthProvider>().adminModel!.role == 'Admin'
                            ? true
                            : false,
                    data: provider.adminModel!.role,
                    title: "Role",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.01,
                      right: MediaQuery.of(context).size.width * 0.28),
                  child: InformationUserWidget(
                    dataAdmin: provider.adminModel!,
                    code: 4,
                    isEditable: false,
                    data: provider.adminModel!.lastLogin,
                    title: "Last login",
                  ),
                ),
              ],
            );
          });
        }
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
