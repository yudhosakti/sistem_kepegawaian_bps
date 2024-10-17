import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simpeg/data/pegawai_data.dart';
import 'package:simpeg/provider/auth_provider.dart';
import 'package:simpeg/provider/validate_pegawai_provier.dart';
import 'package:simpeg/view/pages/detail_pegawai_page.dart';

class ValidatePegawaiPage extends StatelessWidget {
  const ValidatePegawaiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Validate Employee"),
        ),
        body: FutureBuilder(
            future: PegawaiData().getAllValidatePegawai(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.data!.isEmpty) {
                return Center(
                  child: Text("No Data Yet Sorry"),
                );
              } else {
                if (context.read<AuthProvider>().adminModel!.role == 'Admin') {
                  context
                      .read<ValidatePegawaiProvier>()
                      .initialData(snapshot.data!);
                } else {
                  context.read<ValidatePegawaiProvier>().staffInitialData(
                      snapshot.data!,
                      context.read<AuthProvider>().adminModel!.username);
                }

                return Consumer<ValidatePegawaiProvier>(
                    builder: (context, provider, child) {
                  return provider.pegawaiModel.isNotEmpty
                      ? ListView.builder(
                          itemCount: provider.pegawaiModel.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.01,
                                  vertical: MediaQuery.of(context).size.height *
                                      0.002),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return DetailPegawaiPage(
                                          idPegawai: provider
                                              .pegawaiModel[index].idPegawai);
                                    },
                                  ));
                                },
                                child: Card(
                                  elevation: 4,
                                  color: Colors.white,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.09,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.005),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.18,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.grey,
                                              image: provider
                                                          .pegawaiModel[index]
                                                          .foto ==
                                                      ''
                                                  ? DecorationImage(
                                                      opacity: 0.6,
                                                      image: AssetImage(
                                                          'assets/default_profile.jpg'))
                                                  : DecorationImage(
                                                      image: NetworkImage(
                                                          provider
                                                              .pegawaiModel[
                                                                  index]
                                                              .foto)),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                maxLines: 1,
                                                overflow: TextOverflow.fade,
                                                provider.pegawaiModel[index]
                                                    .namaPegawai,
                                                style: GoogleFonts.nunito(
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              Text(
                                                maxLines: 1,
                                                overflow: TextOverflow.fade,
                                                "create : ${provider.pegawaiModel[index].createBy}",
                                                style: GoogleFonts.nunito(
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                            child: Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          content: Text(
                                                            "Apakah anda yakin ingin menghapus pegawai ini ?",
                                                            style: GoogleFonts
                                                                .nunito(
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
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: Text(
                                                                  "Cancel",
                                                                  style: GoogleFonts.nunito(
                                                                      color: Colors
                                                                          .redAccent,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          18),
                                                                )),
                                                            TextButton(
                                                                onPressed:
                                                                    () async {
                                                                  if (await provider
                                                                      .deleteSelectedPegawai(
                                                                          index)) {
                                                                    print(
                                                                        "Success");
                                                                    Navigator.pop(
                                                                        context);
                                                                  } else {
                                                                    print(
                                                                        "Failed");
                                                                    Navigator.pop(
                                                                        context);
                                                                  }
                                                                },
                                                                child: Text(
                                                                  "Ok",
                                                                  style: GoogleFonts.nunito(
                                                                      color: Colors
                                                                          .blueAccent,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          18),
                                                                ))
                                                          ],
                                                          title: Text(
                                                            "Hapus Pegawai",
                                                            style: GoogleFonts
                                                                .nunito(
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
                                                    size: 38,
                                                    Icons.delete,
                                                    color: Colors.redAccent,
                                                  )),
                                              context
                                                          .read<AuthProvider>()
                                                          .adminModel!
                                                          .role ==
                                                      'Admin'
                                                  ? IconButton(
                                                      style: ButtonStyle(
                                                          backgroundColor:
                                                              WidgetStatePropertyAll(
                                                                  Colors
                                                                      .blueAccent)),
                                                      onPressed: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              content: Text(
                                                                "Apakah anda yakin ingin validasi pegawai ini ?",
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
                                                                      if (await provider.updateValidatePegawai(
                                                                          index,
                                                                          context
                                                                              .read<AuthProvider>()
                                                                              .adminModel!
                                                                              .idAdmin)) {
                                                                        print(
                                                                            "Success");
                                                                        Navigator.pop(
                                                                            context);
                                                                      } else {
                                                                        print(
                                                                            "Failed");
                                                                        Navigator.pop(
                                                                            context);
                                                                      }
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
                                                                "Validate Employee",
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
                                                        size: 24,
                                                        Icons.check,
                                                        color: Colors.white,
                                                      ))
                                                  : Container(),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.03,
                                              )
                                            ],
                                          ),
                                        ))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Text(
                            "Belum Ada Pegawai Yang ditambahkan",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                          ),
                        );
                });
              }
            }));
  }
}
