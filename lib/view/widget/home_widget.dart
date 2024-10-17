import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simpeg/data/admin_data.dart';
import 'package:simpeg/data/pegawai_data.dart';
import 'package:simpeg/models/admin_model.dart';
import 'package:simpeg/provider/auth_provider.dart';
import 'package:simpeg/view/pages/add_employee_page.dart';
import 'package:simpeg/view/pages/add_user_page.dart';
import 'package:simpeg/view/pages/detail_pegawai_page.dart';
import 'package:simpeg/view/pages/detail_user_page.dart';
import 'package:simpeg/view/pages/list_employee_page.dart';
import 'package:simpeg/view/pages/list_user_page.dart';
import 'package:simpeg/view/pages/search_employee_page.dart';
import 'package:simpeg/view/pages/validate_pegawai_page.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return SearchEmployeePage();
                  },
                ));
              },
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ))
        ],
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications,
              color: Colors.white,
            )),
        backgroundColor: Color.fromRGBO(121, 102, 255, 1),
      ),
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.35,
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.3,
                  color: Color.fromRGBO(121, 102, 255, 1),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.01),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.085,
                          child: Row(
                            children: [
                              Consumer<AuthProvider>(
                                  builder: (context, provider, child) {
                                return Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  height: MediaQuery.of(context).size.height,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.004),
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle),
                                          child: Stack(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.01,
                                                    vertical:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.003),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: MediaQuery.of(context)
                                                      .size
                                                      .height,
                                                  decoration: BoxDecoration(
                                                      image: provider
                                                                  .adminModel!
                                                                  .avatar ==
                                                              ''
                                                          ? DecorationImage(
                                                              image: AssetImage(
                                                                  'assets/default_profile.jpg'))
                                                          : DecorationImage(
                                                              image: NetworkImage(
                                                                  provider
                                                                      .adminModel!
                                                                      .avatar),
                                                              fit:
                                                                  BoxFit.cover),
                                                      color: Colors.amberAccent,
                                                      shape: BoxShape.circle),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              provider.adminModel!.username,
                                              style: GoogleFonts.mulish(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.005,
                                            ),
                                            Text(
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              provider.adminModel!.email,
                                              style: GoogleFonts.mulish(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ))
                                    ],
                                  ),
                                );
                              })
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.04),
                    child: Card(
                      elevation: 5,
                      color: Colors.white,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.2,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.01),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 3),
                                      child: Text(
                                        "User Menu",
                                        style: GoogleFonts.mulish(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 1,
                              color: Colors.grey,
                            ),
                            Expanded(
                                child: context
                                            .read<AuthProvider>()
                                            .adminModel!
                                            .role !=
                                        'User'
                                    ? Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.05,
                                            ),
                                            MenuButtonWidget(
                                              route: AddEmployeePage(),
                                              sub: "Employee",
                                              title: "Add",
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.03,
                                            ),
                                            context
                                                        .read<AuthProvider>()
                                                        .adminModel!
                                                        .role ==
                                                    'Admin'
                                                ? MenuButtonWidget(
                                                    route: AddUserPage(),
                                                    sub: "User",
                                                    title: "Add",
                                                  )
                                                : Text(""),
                                            context
                                                        .read<AuthProvider>()
                                                        .adminModel!
                                                        .role ==
                                                    'Admin'
                                                ? SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.03,
                                                  )
                                                : Container(),
                                            MenuButtonWidget(
                                              route: ValidatePegawaiPage(),
                                              title: "Validation",
                                              sub: 'Employee',
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.03,
                                            ),
                                            MenuButtonWidget(
                                              route: AddUserPage(),
                                              sub: 'Activity',
                                              title: "Log",
                                            )
                                          ],
                                        ),
                                      )
                                    : Center(
                                        child: Text(
                                          "User Hanya Bisa Melihat Data",
                                          style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16),
                                        ),
                                      ))
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.01),
            child: Card(
              elevation: 5,
              color: Colors.blueAccent,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.18,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.01),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.04,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Recent Employee",
                              style: GoogleFonts.mulish(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return ListEmployeePage();
                                    },
                                  ));
                                },
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        child: Container(
                      child: FutureBuilder(
                          future: PegawaiData().getRecentPegawai(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.data!.isEmpty) {
                              return Center(
                                child: Text("No Data Yet Sorry"),
                              );
                            } else {
                              return ListView.builder(
                                itemCount: snapshot.data!.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width *
                                                0.01,
                                        vertical:
                                            MediaQuery.of(context).size.height *
                                                0.005),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return DetailPegawaiPage(
                                                idPegawai: snapshot
                                                    .data![index].idPegawai);
                                          },
                                        ));
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.18,
                                        height:
                                            MediaQuery.of(context).size.height,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.07,
                                              decoration: BoxDecoration(
                                                  image: snapshot.data![index]
                                                              .foto ==
                                                          ''
                                                      ? DecorationImage(
                                                          opacity: 0.6,
                                                          image: AssetImage(
                                                              'assets/default_profile.jpg'),
                                                        )
                                                      : DecorationImage(
                                                          image: NetworkImage(
                                                              snapshot
                                                                  .data![index]
                                                                  .foto)),
                                                  color: Colors.grey,
                                                  shape: BoxShape.circle),
                                            ),
                                            Text(
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              snapshot.data![index].namaPegawai,
                                              style: GoogleFonts.nunito(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          }),
                    ))
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.01),
            child: Card(
              elevation: 5,
              color: Colors.redAccent,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.18,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.01),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.04,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Recent User",
                              style: GoogleFonts.mulish(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return ListUserPage();
                                    },
                                  ));
                                },
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        child: Container(
                      child: FutureBuilder(
                          future: AdminData().getRecentUser(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.data!.isEmpty) {
                              return Center(
                                child: Text("No Data Yet Sorry"),
                              );
                            } else {
                              List<AdminModel> adminList = [];
                              for (var element in snapshot.data!) {
                                if (context
                                        .read<AuthProvider>()
                                        .adminModel!
                                        .idAdmin !=
                                    element.idAdmin) {
                                  adminList.add(element);
                                }
                              }
                              return ListView.builder(
                                itemCount: adminList.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width *
                                                0.01,
                                        vertical:
                                            MediaQuery.of(context).size.height *
                                                0.005),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return DetailUserPage(
                                                adminModel: adminList[index]);
                                          },
                                        ));
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.18,
                                        height:
                                            MediaQuery.of(context).size.height,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.07,
                                              decoration: BoxDecoration(
                                                  image: adminList[index]
                                                              .avatar ==
                                                          ''
                                                      ? DecorationImage(
                                                          opacity: 0.6,
                                                          image: AssetImage(
                                                              'assets/default_profile.jpg'),
                                                        )
                                                      : DecorationImage(
                                                          image: NetworkImage(
                                                              adminList[index]
                                                                  .avatar)),
                                                  color: Colors.grey,
                                                  shape: BoxShape.circle),
                                            ),
                                            Text(
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              adminList[index].username,
                                              style: GoogleFonts.nunito(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          }),
                    ))
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

class MenuButtonWidget extends StatelessWidget {
  final String title;
  final String sub;
  final Widget route;
  const MenuButtonWidget(
      {super.key, required this.sub, required this.title, required this.route});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.18,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.008,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.065,
            decoration: BoxDecoration(
                color: Color.fromRGBO(241, 238, 252, 1),
                shape: BoxShape.circle),
            child: Center(
              child: IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return route;
                      },
                    ));
                  },
                  icon: Icon(
                    Icons.group,
                    size: 38,
                    color: Colors.black,
                  )),
            ),
          ),
          Expanded(
              child: Container(
                  child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title),
              Text(sub),
            ],
          ))),
        ],
      ),
    );
  }
}
