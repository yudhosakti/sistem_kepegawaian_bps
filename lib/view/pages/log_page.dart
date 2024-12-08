import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simpeg/data/admin_data.dart';
import 'package:simpeg/provider/auth_provider.dart';
import 'package:simpeg/provider/log_provider.dart';

class LogPage extends StatelessWidget {
  const LogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Log Activity",
          style: GoogleFonts.poppins(
              color: Colors.black, fontWeight: FontWeight.w500),
        ),
      ),
      body: FutureBuilder(
          future: AdminData()
              .getLogData(context.read<AuthProvider>().adminModel!.idAdmin),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data == null || snapshot.data!.isEmpty) {
              return Center(
                child: Text(
                  "No Data Yet",
                  style: GoogleFonts.poppins(color: Colors.black, fontSize: 20),
                ),
              );
            } else {
              context.read<LogProvider>().setLogList(snapshot.data!);
              return Consumer<LogProvider>(builder: (context, provider, child) {
                return ListView.builder(
                  itemCount: provider.logList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Center(
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.95,
                                  height:
                                      MediaQuery.of(context).size.height * 0.35,
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.04,
                                        color: Color.fromRGBO(93, 121, 150, 1),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 5),
                                            child: Text(
                                              "Log Detail",
                                              style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.15,
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 4),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Username : ${provider.logList[index].namaUser}",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize: 20),
                                              ),
                                              Text(
                                                "role : ${provider.logList[index].role}",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize: 20),
                                              ),
                                              Text(
                                                "Status : ${provider.logList[index].status}",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize: 20),
                                              ),
                                              Text(
                                                "Create At : ${provider.logList[index].createAt}",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize: 20),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          child: Card(
                                        color: Colors.white,
                                        elevation: 5,
                                        child: Container(
                                          child: Center(
                                            child: Padding(
                                              padding: EdgeInsets.only(left: 3),
                                              child: Text(
                                                maxLines: 3,
                                                provider.logList[index].message,
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize: 22),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ))
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Card(
                          color: Colors.white,
                          elevation: 8,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.145,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width *
                                          0.004),
                              child: Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.04,
                                    decoration: BoxDecoration(
                                        color: Colors.blueAccent,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 5),
                                        child: Text(
                                          provider.logList[index].namaUser,
                                          style: GoogleFonts.poppins(
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        provider.logList[index].message,
                                        style: GoogleFonts.poppins(
                                            color: Colors.black, fontSize: 20),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 3),
                                      child: Text(
                                        provider.logList[index].createAt,
                                        style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              });
            }
          }),
    );
  }
}
