import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simpeg/data/pegawai_data.dart';
import 'package:simpeg/provider/auth_provider.dart';
import 'package:simpeg/provider/detail_pegawai_provider.dart';

class DetailPegawaiPage extends StatelessWidget {
  final int idPegawai;
  const DetailPegawaiPage({super.key, required this.idPegawai});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail Pegawai",
          style: GoogleFonts.nunito(
              color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: FutureBuilder(
          future: PegawaiData().getDetailPegawai(idPegawai),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data == null) {
              return Center(
                child: Text(
                  "Data Not Found",
                  style: GoogleFonts.nunito(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 23),
                ),
              );
            } else {
              context
                  .read<DetailPegawaiProvider>()
                  .setInitialPegawai(snapshot.data!);
              context.read<DetailPegawaiProvider>().resetAll();
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.01),
                child: Consumer<DetailPegawaiProvider>(
                    builder: (context, provider, child) {
                  if (provider.pegawaiDetailModel == null) {
                    return Center(
                      child: Text(
                        "Data Not Found",
                        style: GoogleFonts.nunito(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 23),
                      ),
                    );
                  } else {
                    return ListView(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                              Builder(builder: (context) {
                                if (provider.fileImage == null) {
                                  return Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    height: MediaQuery.of(context).size.height,
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        shape: BoxShape.circle,
                                        image: provider
                                                    .pegawaiDetailModel!.foto ==
                                                ''
                                            ? DecorationImage(
                                                opacity: 0.6,
                                                image: AssetImage(
                                                    'assets/default_profile.jpg'))
                                            : DecorationImage(
                                                image: NetworkImage(provider
                                                    .pegawaiDetailModel!.foto),
                                                fit: BoxFit.fill)),
                                    child: context
                                                .read<AuthProvider>()
                                                .adminModel!
                                                .role ==
                                            'Admin'
                                        ? Stack(
                                            children: [
                                              Positioned(
                                                right: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.03,
                                                bottom: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.01,
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.1,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.05,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: IconButton(
                                                      onPressed: () async {
                                                        if (await provider
                                                            .takePickture()) {
                                                          Fluttertoast.showToast(
                                                              msg: "Success");
                                                        } else {
                                                          Fluttertoast.showToast(
                                                              msg: "Canceled");
                                                        }
                                                      },
                                                      icon: Icon(
                                                        Icons.image,
                                                        color: Colors.black,
                                                      )),
                                                ),
                                              )
                                            ],
                                          )
                                        : Container(),
                                  );
                                } else {
                                  return Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    height: MediaQuery.of(context).size.height,
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image:
                                                FileImage(provider.fileImage!),
                                            fit: BoxFit.fill)),
                                    child: context
                                                .read<AuthProvider>()
                                                .adminModel!
                                                .role ==
                                            'Admin'
                                        ? Stack(
                                            children: [
                                              Positioned(
                                                right: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.03,
                                                bottom: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.01,
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.1,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.05,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: IconButton(
                                                      onPressed: () async {
                                                        if (await provider
                                                            .takePickture()) {
                                                          Fluttertoast.showToast(
                                                              msg: "Success");
                                                        } else {
                                                          Fluttertoast.showToast(
                                                              msg: "Canceled");
                                                        }
                                                      },
                                                      icon: Icon(
                                                        Icons.image,
                                                        color: Colors.black,
                                                      )),
                                                ),
                                              )
                                            ],
                                          )
                                        : Container(),
                                  );
                                }
                              }),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                              Expanded(
                                  child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InformationDetailComponentWidget(
                                      code: 1,
                                      isEditable: context
                                                  .read<AuthProvider>()
                                                  .adminModel!
                                                  .role ==
                                              'Admin'
                                          ? true
                                          : false,
                                      data: provider
                                          .pegawaiDetailModel!.namaPegawai,
                                      title: "Nama Lengkap",
                                    ),
                                    InformationDetailComponentWidget(
                                      code: 2,
                                      isEditable: context
                                                  .read<AuthProvider>()
                                                  .adminModel!
                                                  .role ==
                                              'Admin'
                                          ? true
                                          : false,
                                      data: provider.pegawaiDetailModel!.newNip
                                          .toString(),
                                      title: "New NIP",
                                    )
                                  ],
                                ),
                              ))
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * 0.3),
                          child: InformationDetailComponentWidget(
                            code: 3,
                            isEditable:
                                context.read<AuthProvider>().adminModel!.role ==
                                        'Admin'
                                    ? true
                                    : false,
                            data:
                                provider.pegawaiDetailModel!.oldNip.toString(),
                            title: "Old NIP",
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * 0.3),
                          child: InformationDetailComponentWidget(
                            code: 4,
                            isEditable:
                                context.read<AuthProvider>().adminModel!.role ==
                                        'Admin'
                                    ? true
                                    : false,
                            data: provider.pegawaiDetailModel!.jenisKelamin,
                            title: "Jenis Kelamin",
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * 0.3),
                          child: InformationDetailComponentWidget(
                            code: 5,
                            isEditable:
                                context.read<AuthProvider>().adminModel!.role ==
                                        'Admin'
                                    ? true
                                    : false,
                            data: provider.pegawaiDetailModel!.tempatLahir,
                            title: "Tempat Lahir",
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * 0.3),
                          child: InformationDetailComponentWidget(
                            code: 6,
                            isEditable:
                                context.read<AuthProvider>().adminModel!.role ==
                                        'Admin'
                                    ? true
                                    : false,
                            data: provider.pegawaiDetailModel!.tanggalLahir,
                            title: "Tanggal Lahir",
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * 0.3),
                          child: InformationDetailComponentWidget(
                            code: 7,
                            isEditable:
                                context.read<AuthProvider>().adminModel!.role ==
                                        'Admin'
                                    ? true
                                    : false,
                            data: provider.pegawaiDetailModel!.golongan,
                            title: "Golongan",
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * 0.3),
                          child: InformationDetailComponentWidget(
                            code: 8,
                            isEditable:
                                context.read<AuthProvider>().adminModel!.role ==
                                        'Admin'
                                    ? true
                                    : false,
                            data: provider.pegawaiDetailModel!.pangkat,
                            title: "Pangkat",
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * 0.3),
                          child: InformationDetailComponentWidget(
                            code: 9,
                            isEditable:
                                context.read<AuthProvider>().adminModel!.role ==
                                        'Admin'
                                    ? true
                                    : false,
                            data: provider.pegawaiDetailModel!.pendidikan,
                            title: "Pendidikan Terakhir",
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * 0.3),
                          child: InformationDetailComponentWidget(
                            code: 10,
                            isEditable:
                                context.read<AuthProvider>().adminModel!.role ==
                                        'Admin'
                                    ? true
                                    : false,
                            data: provider.pegawaiDetailModel!.jabatan,
                            title: "Jabatan",
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * 0.3),
                          child: InformationDetailComponentWidget(
                            code: 11,
                            isEditable:
                                context.read<AuthProvider>().adminModel!.role ==
                                        'Admin'
                                    ? true
                                    : false,
                            data:
                                provider.pegawaiDetailModel!.pengalamanJabatan,
                            title: "Pengalaman Jabatan",
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        CustomViewDetailPegawaiWidget(
                          code: 1,
                          btnTitle: "Tambah Sertifikat",
                          itemTitle: "Sertifikat",
                          title: "Sertifikat Pegawai",
                        ),
                        context.read<AuthProvider>().adminModel!.role == 'Admin'
                            ? CustomViewDetailPegawaiWidget(
                                code: 2,
                                btnTitle: "Tambah Kelebihan",
                                itemTitle: "Kelebihan",
                                title: "Kelebihan Pegawai",
                              )
                            : Container(),
                        context.read<AuthProvider>().adminModel!.role == 'Admin'
                            ? CustomViewDetailPegawaiWidget(
                                code: 3,
                                btnTitle: "Tambah Kekurangan",
                                itemTitle: "Kekurangan",
                                title: "Kekurangan Pegawai",
                              )
                            : Container(),
                        CustomViewDetailPegawaiWidget(
                          code: 4,
                          btnTitle: "Tambah Diklat",
                          itemTitle: "Diklat",
                          title: "Diklat Pegawai",
                        )
                      ],
                    );
                  }
                }),
              );
            }
          }),
    );
  }
}

class CustomViewDetailPegawaiWidget extends StatelessWidget {
  final String title;
  final String itemTitle;
  final int code;
  final String btnTitle;
  const CustomViewDetailPegawaiWidget(
      {super.key,
      required this.code,
      required this.btnTitle,
      required this.title,
      required this.itemTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.005),
      child:
          Consumer<DetailPegawaiProvider>(builder: (context, provider, child) {
        return Container(
          width: MediaQuery.of(context).size.width,
          constraints: BoxConstraints(
              maxHeight: double.infinity,
              minHeight: MediaQuery.of(context).size.height * 0.1),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.04,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.005),
                        child: Text(
                          title,
                          style: GoogleFonts.nunito(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 17),
                        ),
                      ),
                    ),
                    context.read<AuthProvider>().adminModel!.role == 'Admin'
                        ? Consumer<DetailPegawaiProvider>(
                            builder: (context, provider, child) {
                            return ElevatedButton(
                                style: ButtonStyle(
                                    shape: WidgetStatePropertyAll(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)))),
                                    backgroundColor: WidgetStatePropertyAll(
                                        Colors.blueAccent),
                                    padding: WidgetStatePropertyAll(
                                        EdgeInsets.symmetric(
                                            horizontal: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.01))),
                                onPressed: () {
                                  provider.resetBehavior();
                                  ScaffoldMessenger.of(context)
                                      .clearSnackBars();
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          duration: Duration(days: 365),
                                          content: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.13,
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.08,
                                                  child: Center(
                                                    child: Padding(
                                                      padding: EdgeInsets.symmetric(
                                                          horizontal:
                                                              MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.01,
                                                          vertical: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.005),
                                                      child: TextFormField(
                                                        controller: provider
                                                            .etEditOtherField,
                                                        decoration: InputDecoration(
                                                            hintText:
                                                                "Tambah ${title}",
                                                            border: OutlineInputBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            12))),
                                                            filled: true,
                                                            fillColor:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                    child: Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      TextButton(
                                                          onPressed: () {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .clearSnackBars();
                                                            provider
                                                                .resetBehavior();
                                                          },
                                                          child: Text(
                                                            "Cancel",
                                                            style: GoogleFonts
                                                                .nunito(
                                                                    color: Colors
                                                                        .red,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        20),
                                                          )),
                                                      TextButton(
                                                          onPressed: () async {
                                                            if (await provider
                                                                .createNewBehavior(
                                                                    code,
                                                                    context
                                                                        .read<
                                                                            AuthProvider>()
                                                                        .adminModel!
                                                                        .idAdmin)) {
                                                              Fluttertoast
                                                                  .showToast(
                                                                      msg:
                                                                          "Berhasil Tambah");
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .clearSnackBars();
                                                            } else {
                                                              Fluttertoast
                                                                  .showToast(
                                                                      msg:
                                                                          "Gagal Tambah");
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .clearSnackBars();
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
                                                                fontSize: 20),
                                                          ))
                                                    ],
                                                  ),
                                                ))
                                              ],
                                            ),
                                          )));
                                },
                                child: Text(
                                  btnTitle,
                                  style: GoogleFonts.nunito(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ));
                          })
                        : Container()
                  ],
                ),
              ),
              Builder(builder: (context) {
                if (code == 1) {
                  if (provider.pegawaiDetailModel!.certificates.isEmpty) {
                    return NoDataWidget();
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount:
                          provider.pegawaiDetailModel!.certificates.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ItemDetailComponentWidget(
                          code: code,
                          idData: provider.pegawaiDetailModel!
                              .certificates[index].idSertifikat,
                          itemTitle: itemTitle,
                          index: index,
                          data: provider.pegawaiDetailModel!.certificates[index]
                              .namaSertifikat,
                        );
                      },
                    );
                  }
                } else if (code == 2) {
                  if (provider.pegawaiDetailModel!.kelebihan.isEmpty) {
                    return NoDataWidget();
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: provider.pegawaiDetailModel!.kelebihan.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ItemDetailComponentWidget(
                          code: code,
                          idData: provider
                              .pegawaiDetailModel!.kelebihan[index].idKelebihan,
                          itemTitle: itemTitle,
                          index: index,
                          data: provider
                              .pegawaiDetailModel!.kelebihan[index].kelebihan,
                        );
                      },
                    );
                  }
                } else if (code == 3) {
                  if (provider.pegawaiDetailModel!.kekurangan.isEmpty) {
                    return NoDataWidget();
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: provider.pegawaiDetailModel!.kekurangan.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ItemDetailComponentWidget(
                          code: code,
                          idData: provider.pegawaiDetailModel!.kekurangan[index]
                              .idKekurangan,
                          itemTitle: itemTitle,
                          index: index,
                          data: provider
                              .pegawaiDetailModel!.kekurangan[index].kekurangan,
                        );
                      },
                    );
                  }
                } else {
                  if (provider.pegawaiDetailModel!.diklat.isEmpty) {
                    return NoDataWidget();
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: provider.pegawaiDetailModel!.diklat.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ItemDetailComponentWidget(
                          code: code,
                          idData: provider
                              .pegawaiDetailModel!.diklat[index].idDiklat,
                          itemTitle: itemTitle,
                          index: index,
                          data:
                              provider.pegawaiDetailModel!.diklat[index].diklat,
                        );
                      },
                    );
                  }
                }
              }),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              )
            ],
          ),
        );
      }),
    );
  }
}

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.12,
      child: Center(
        child: Text("No Data Yet"),
      ),
    );
  }
}

class ItemDetailComponentWidget extends StatelessWidget {
  const ItemDetailComponentWidget(
      {super.key,
      required this.data,
      required this.index,
      required this.code,
      required this.itemTitle,
      required this.idData});
  final int index;
  final int idData;
  final int code;
  final String data;
  final String itemTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child:
          Consumer<DetailPegawaiProvider>(builder: (context, provider, child) {
        return Card(
          color: Color.fromRGBO(247, 247, 247, 1),
          elevation: 5,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width,
              minWidth: MediaQuery.of(context).size.width,
              maxHeight: double.infinity,
              minHeight: MediaQuery.of(context).size.height * 0.08,
            ),
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.08,
                  constraints: BoxConstraints(
                    maxHeight: double.infinity,
                    minHeight: MediaQuery.of(context).size.height * 0.08,
                  ),
                  child: Center(
                    child: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Konfirmasi Hapus ${itemTitle}"),
                                content: Text(
                                    "Apakah anda yakin ingin menghapus ${itemTitle} ini"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "Cancel",
                                        style: GoogleFonts.nunito(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 19),
                                      )),
                                  TextButton(
                                      onPressed: () async {
                                        if (await provider.deleteNewBehavior(
                                            code, idData)) {
                                          Fluttertoast.showToast(
                                              msg: "Berhasil Hapus");
                                          Navigator.pop(context);
                                        } else {
                                          Fluttertoast.showToast(
                                              msg: "Gagal Hapus");
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: Text(
                                        "Ok",
                                        style: GoogleFonts.nunito(
                                            color: Colors.blueAccent,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 19),
                                      ))
                                ],
                              );
                            },
                          );
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                  ),
                ),
                Expanded(
                    child: Container(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.04,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "${itemTitle} ${index + 1}",
                                style: GoogleFonts.nunito(
                                    color: Colors.black,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            context.read<AuthProvider>().adminModel!.role ==
                                    'Admin'
                                ? IconButton(
                                    style: ButtonStyle(
                                        padding: WidgetStatePropertyAll(
                                            EdgeInsets.zero)),
                                    onPressed: () {
                                      provider.etUpdateOtherField.text = data;
                                      ScaffoldMessenger.of(context)
                                          .clearSnackBars();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              duration: Duration(days: 365),
                                              content: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.13,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.08,
                                                      child: Center(
                                                        child: Padding(
                                                          padding: EdgeInsets.symmetric(
                                                              horizontal:
                                                                  MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.01,
                                                              vertical: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.005),
                                                          child: TextFormField(
                                                            controller: provider
                                                                .etUpdateOtherField,
                                                            decoration: InputDecoration(
                                                                hintText:
                                                                    "Edit ${itemTitle}",
                                                                border: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(Radius.circular(
                                                                            12))),
                                                                filled: true,
                                                                fillColor:
                                                                    Colors
                                                                        .white),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                        child: Container(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          TextButton(
                                                              onPressed: () {
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .clearSnackBars();
                                                              },
                                                              child: Text(
                                                                "Cancel",
                                                                style: GoogleFonts.nunito(
                                                                    color: Colors
                                                                        .red,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        20),
                                                              )),
                                                          TextButton(
                                                              onPressed:
                                                                  () async {
                                                                if (await provider.updateNewBehavior(
                                                                    code,
                                                                    idData,
                                                                    context
                                                                        .read<
                                                                            AuthProvider>()
                                                                        .adminModel!
                                                                        .idAdmin,
                                                                    provider
                                                                        .etUpdateOtherField
                                                                        .text)) {
                                                                  Fluttertoast
                                                                      .showToast(
                                                                          msg:
                                                                              "Berhasil Update");
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .clearSnackBars();
                                                                } else {
                                                                  Fluttertoast
                                                                      .showToast(
                                                                          msg:
                                                                              "Gagal Update");
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .clearSnackBars();
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
                                                                        20),
                                                              ))
                                                        ],
                                                      ),
                                                    ))
                                                  ],
                                                ),
                                              )));
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.black,
                                    ))
                                : Container()
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          data,
                          style: GoogleFonts.nunito(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                      )
                    ],
                  ),
                ))
              ],
            ),
          ),
        );
      }),
    );
  }
}

class InformationDetailComponentWidget extends StatelessWidget {
  final String title;
  final bool isEditable;
  final int code;
  final String data;
  const InformationDetailComponentWidget(
      {super.key,
      required this.data,
      required this.code,
      required this.title,
      required this.isEditable});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.01),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6))),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.08,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.04,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 1),
                      child: Text(
                        title,
                        style: GoogleFonts.nunito(
                            color: Colors.black,
                            fontSize: 19,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    isEditable
                        ? Consumer<DetailPegawaiProvider>(
                            builder: (context, provider, child) {
                            return IconButton(
                                onPressed: () {
                                  provider.etEditField.text = data;
                                  ScaffoldMessenger.of(context)
                                      .clearSnackBars();
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          duration: Duration(days: 365),
                                          content: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.13,
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.08,
                                                  child: Center(
                                                    child: Padding(
                                                      padding: EdgeInsets.symmetric(
                                                          horizontal:
                                                              MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.01,
                                                          vertical: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.005),
                                                      child: TextFormField(
                                                        controller: provider
                                                            .etEditField,
                                                        decoration: InputDecoration(
                                                            hintText:
                                                                "Edit ${title}",
                                                            border: OutlineInputBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            12))),
                                                            filled: true,
                                                            fillColor:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                    child: Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      TextButton(
                                                          onPressed: () {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .clearSnackBars();
                                                          },
                                                          child: Text(
                                                            "Cancel",
                                                            style: GoogleFonts
                                                                .nunito(
                                                                    color: Colors
                                                                        .red,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        20),
                                                          )),
                                                      TextButton(
                                                          onPressed: () async {
                                                            if (await provider
                                                                .updatePegawai(
                                                                    code,
                                                                    context
                                                                        .read<
                                                                            AuthProvider>()
                                                                        .adminModel!
                                                                        .idAdmin)) {
                                                              if (await provider
                                                                  .getPegawaiDetail(provider
                                                                      .pegawaiDetailModel!
                                                                      .idPegawai)) {
                                                                Fluttertoast
                                                                    .showToast(
                                                                        msg:
                                                                            "Berhasil Update");
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .clearSnackBars();
                                                              } else {
                                                                Fluttertoast
                                                                    .showToast(
                                                                        msg:
                                                                            "Terjadi Kesalahan");
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .clearSnackBars();
                                                              }
                                                            } else {
                                                              Fluttertoast
                                                                  .showToast(
                                                                      msg:
                                                                          "Gagal Update");
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .clearSnackBars();
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
                                                                fontSize: 20),
                                                          ))
                                                    ],
                                                  ),
                                                ))
                                              ],
                                            ),
                                          )));
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                ));
                          })
                        : Container()
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 1),
                    child: Text(
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      data,
                      style: GoogleFonts.nunito(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
