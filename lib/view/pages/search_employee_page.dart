import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simpeg/data/pegawai_data.dart';
import 'package:simpeg/provider/auth_provider.dart';
import 'package:simpeg/provider/search_pegawai_provider.dart';
import 'package:simpeg/view/pages/detail_pegawai_page.dart';

class SearchEmployeePage extends StatelessWidget {
  const SearchEmployeePage({super.key});

  double getWidth() {
    FlutterView view = PlatformDispatcher.instance.views.first;

    double physicalWidth = view.physicalSize.width;

    double devicePixelRatio = view.devicePixelRatio;

    double screenWidth = physicalWidth / devicePixelRatio;
    return screenWidth;
  }

  double getHeight() {
    FlutterView view = PlatformDispatcher.instance.views.first;
    double physicalHeight = view.physicalSize.height;

    double devicePixelRatio = view.devicePixelRatio;
    double screenHeight = physicalHeight / devicePixelRatio;
    return screenHeight;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Cari Pegawai",
            style: GoogleFonts.nunito(
                color: Colors.black, fontWeight: FontWeight.w600),
          ),
        ),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getWidth() * 0.01, vertical: getHeight() * 0.005),
              child: Container(
                width: getWidth(),
                height: getHeight() * 0.08,
                child: Consumer<SearchPegawaiProvider>(
                    builder: (contextd, provider, child) {
                  return TextFormField(
                    controller: provider.etSearch,
                    onEditingComplete: () async {
                      if (await provider.getSearchPegawai()) {
                        print("Search");
                      } else {
                        print("All");
                      }
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        hintText: "Cari Pegawai",
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        disabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12)))),
                  );
                }),
              ),
            ),
            FutureBuilder(
                future: PegawaiData().getAllPegawai(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return LoadingWidget();
                  } else if (snapshot.data!.isEmpty) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    context
                        .read<SearchPegawaiProvider>()
                        .getInitialPegawai(snapshot.data!);
                    return Consumer<SearchPegawaiProvider>(
                        builder: (context, provider, child) {
                      return ListView.builder(
                        itemCount: provider.pegawaiList.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: getWidth() * 0.01,
                                vertical: getHeight() * 0.002),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return DetailPegawaiPage(
                                        idPegawai: provider
                                            .pegawaiList[index].idPegawai);
                                  },
                                ));
                              },
                              child: Card(
                                elevation: 4,
                                color: Colors.white,
                                child: Container(
                                  width: getWidth(),
                                  height: getHeight() * 0.08,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: getHeight() * 0.005),
                                        child: Container(
                                          width: getWidth() * 0.18,
                                          height: getHeight(),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.grey,
                                            image: provider.pegawaiList[index]
                                                        .foto ==
                                                    ''
                                                ? DecorationImage(
                                                    opacity: 0.6,
                                                    image: AssetImage(
                                                        'assets/default_profile.jpg'),
                                                  )
                                                : DecorationImage(
                                                    image: NetworkImage(provider
                                                        .pegawaiList[index]
                                                        .foto),
                                                    fit: BoxFit.fill),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: getWidth() * 0.65,
                                        height: getHeight(),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              maxLines: 1,
                                              overflow: TextOverflow.fade,
                                              provider.pegawaiList[index]
                                                  .namaPegawai,
                                              style: GoogleFonts.nunito(
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            Text(
                                              maxLines: 1,
                                              overflow: TextOverflow.fade,
                                              provider
                                                  .pegawaiList[index].pangkat,
                                              style: GoogleFonts.nunito(
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                          child: Container(
                                        child: Center(
                                          child:
                                              context
                                                          .read<AuthProvider>()
                                                          .adminModel!
                                                          .role ==
                                                      'Admin'
                                                  ? IconButton(
                                                      onPressed: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              content: Text(
                                                                "Apakah anda yakin ingin menghapus pegawai ini ?",
                                                                style: GoogleFonts.nunito(
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        17),
                                                              ),
                                                              actions: [
                                                                TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child: Text(
                                                                      "Cancel",
                                                                      style: GoogleFonts.nunito(
                                                                          color: Colors
                                                                              .redAccent,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          fontSize:
                                                                              18),
                                                                    )),
                                                                TextButton(
                                                                    onPressed:
                                                                        () async {
                                                                      provider.deleteSelectedPegawai(provider
                                                                          .pegawaiList[
                                                                              index]
                                                                          .idPegawai);
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child: Text(
                                                                      "Ok",
                                                                      style: GoogleFonts.nunito(
                                                                          color: Colors
                                                                              .blueAccent,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          fontSize:
                                                                              18),
                                                                    ))
                                                              ],
                                                              title: Text(
                                                                "Hapus Pegawai",
                                                                style: GoogleFonts.nunito(
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        20),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                      icon: Icon(
                                                        size: 32,
                                                        Icons.delete,
                                                        color: Colors.redAccent,
                                                      ))
                                                  : Container(),
                                        ),
                                      ))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    });
                  }
                })
          ],
        ));
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.2,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
