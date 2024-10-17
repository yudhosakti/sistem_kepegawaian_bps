import 'dart:developer';

import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:simpeg/provider/auth_provider.dart';
import 'package:simpeg/provider/tambah_karyawan_provider.dart';
import 'package:simpeg/view/widget/custom_item_component_widget.dart';
import 'package:simpeg/view/widget/drop_down_custom_widget.dart';
import 'package:simpeg/view/widget/single_form_widget.dart';

class AddEmployeePage extends StatelessWidget {
  const AddEmployeePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Tambah Pegawai",
          style: GoogleFonts.nunito(
              color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body:
          Consumer<TambahKaryawanProvider>(builder: (context, provider, child) {
        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.005),
          child: ListView(
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
                        image: provider.fileImage == null
                            ? DecorationImage(
                                opacity: 0.6,
                                image: AssetImage('assets/default_profile.jpg'),
                              )
                            : DecorationImage(
                                image: FileImage(provider.fileImage!),
                                fit: BoxFit.fill),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            right: 0,
                            bottom: MediaQuery.of(context).size.height * 0.01,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.1,
                              height: MediaQuery.of(context).size.height * 0.05,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.redAccent),
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      shape: WidgetStatePropertyAll(
                                          CircleBorder()),
                                      padding: WidgetStatePropertyAll(
                                          EdgeInsets.zero)),
                                  onPressed: () async {
                                    if (await provider.takePickture()) {
                                      log("Success");
                                    } else {
                                      log("Failed");
                                    }
                                  },
                                  child: Icon(
                                    Icons.camera,
                                    color: Colors.black,
                                  )),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SingleFormWidget(
                isEditable: true,
                editingController: provider.namaPegawai,
                hintText: "Masukkan Nama Pegawai",
                title: "Nama Pegawai",
              ),
              SingleFormWidget(
                isEditable: true,
                editingController: provider.OldNipPegawai,
                hintText: "Masukkan NIP Lama",
                title: "Old NIP",
              ),
              SingleFormWidget(
                isEditable: true,
                editingController: provider.NewNipPegawai,
                hintText: "Masukkan NIP Baru",
                title: "New NIP",
              ),
              SingleFormWidget(
                isEditable: true,
                editingController: provider.TempatLahirPegawai,
                hintText: "Masukkan Tempat Lahir",
                title: "Tempat Lahir",
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.01),
                child: Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.005,
                      bottom: MediaQuery.of(context).size.height * 0.005),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.04,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Tanggal Lahir",
                            style: GoogleFonts.nunito(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      Expanded(
                          child: Container(
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * 0.3),
                          child: DateTimeFormField(
                            initialValue: provider.tanggalLahir == null
                                ? null
                                : DateFormat('yyyy-MM-DD')
                                    .parse(provider.tanggalLahir!),
                            mode: DateTimeFieldPickerMode.date,
                            canClear: true,
                            onChanged: (value) {
                              if (value != null) {
                                provider.changeTanggal(value);
                                log(DateFormat('yyyy-MM-DD')
                                    .parse(provider.tanggalLahir!)
                                    .toString());
                              }
                            },
                            decoration: InputDecoration(
                                hintText: "Masukkan Tanggal Lahir",
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                disabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)))),
                          ),
                        ),
                      ))
                    ],
                  ),
                ),
              ),
              SingleFormWidget(
                isEditable: true,
                editingController: provider.JabatanPegawai,
                hintText: "Masukkan Jabatan",
                title: "Jabatan",
              ),
              SingleFormWidget(
                isEditable: true,
                editingController: provider.PengalamanPejabatPegawai,
                hintText: "Masukkan Pengalaman Jabatan",
                title: "Pengalaman Jabatan",
              ),
              DropDownCustomWidget(
                dataValue: provider.jenisKelamin,
                code: 1,
                provider: provider,
                data: provider.dataJenisKelamin,
                hintDataa: "Pilih Gender",
                title: "Jenis Kelamin",
              ),
              DropDownCustomWidget(
                dataValue: provider.golongan,
                code: 2,
                provider: provider,
                data: provider.dataGolongan,
                hintDataa: "Pilih Golongan",
                title: "Golongan",
              ),
              DropDownCustomWidget(
                dataValue: provider.pendidikanTerakhir,
                code: 3,
                provider: provider,
                data: provider.dataPendidikan,
                hintDataa: "Pilih Pendidikan Terakhir",
                title: "Pendidikan Terakhir",
              ),
              SingleFormWidget(
                  editingController: provider.pangkatPegawai,
                  hintText: "Pangkat Pegawai",
                  isEditable: false,
                  title: "Pangkat"),
              Container(
                width: MediaQuery.of(context).size.width,
                constraints: BoxConstraints(
                    maxHeight: double.infinity,
                    minHeight: MediaQuery.of(context).size.height * 0.1),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.04,
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.01),
                          child: Text(
                            "Sertifikat Pegawai",
                            style: GoogleFonts.nunito(
                                fontSize: 19,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    ListView.builder(
                      itemCount: provider.test.length + 1,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        if (index == provider.test.length) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.06,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      provider.tambahSertifikat();
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.black,
                                    ))
                              ],
                            ),
                          );
                        } else {
                          return CustomItemComponentWidget(
                            controller: provider.test[index].namaSertifikat,
                            code: 1,
                            index: index,
                            provider: provider,
                            hintTitle: "Masukkan Nama Sertifikat",
                            title: "Sertifikat ${index + 1}",
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
             context.read<AuthProvider>().adminModel!.role == 'Admin' ? Container(
                width: MediaQuery.of(context).size.width,
                constraints: BoxConstraints(
                    maxHeight: double.infinity,
                    minHeight: MediaQuery.of(context).size.height * 0.1),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.04,
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.01),
                          child: Text(
                            "Kelebihan Pegawai",
                            style: GoogleFonts.nunito(
                                fontSize: 19,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    ListView.builder(
                      itemCount: provider.dataKelebihan.length + 1,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        if (index == provider.dataKelebihan.length) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.06,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      provider.tambahKelebihan();
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.black,
                                    ))
                              ],
                            ),
                          );
                        } else {
                          return CustomItemComponentWidget(
                            controller: provider.dataKelebihan[index].data,
                            code: 2,
                            index: index,
                            provider: provider,
                            hintTitle: "Masukkan Kelebihan Pegawai",
                            title: "Kelebihan ${index + 1}",
                          );
                        }
                      },
                    )
                  ],
                ),
              ) : Container(),
             context.read<AuthProvider>().adminModel!.role == 'Admin' ? Container(
                width: MediaQuery.of(context).size.width,
                constraints: BoxConstraints(
                    maxHeight: double.infinity,
                    minHeight: MediaQuery.of(context).size.height * 0.1),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.04,
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.01),
                          child: Text(
                            "Kekurangan Pegawai",
                            style: GoogleFonts.nunito(
                                fontSize: 19,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    ListView.builder(
                      itemCount: provider.dataKekurangan.length + 1,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        if (index == provider.dataKekurangan.length) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.06,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      provider.tambahKekurangant();
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.black,
                                    ))
                              ],
                            ),
                          );
                        } else {
                          return CustomItemComponentWidget(
                            controller: provider.dataKekurangan[index].data,
                            code: 3,
                            index: index,
                            provider: provider,
                            hintTitle: "Masukkan Kekurangan Pegawai",
                            title: "Kekurangan ${index + 1}",
                          );
                        }
                      },
                    )
                  ],
                ),
              ) : Container(),
              Container(
                width: MediaQuery.of(context).size.width,
                constraints: BoxConstraints(
                    maxHeight: double.infinity,
                    minHeight: MediaQuery.of(context).size.height * 0.1),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.04,
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.01),
                          child: Text(
                            "Diklat Pegawai",
                            style: GoogleFonts.nunito(
                                fontSize: 19,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    ListView.builder(
                      itemCount: provider.dataDiklat.length + 1,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        if (index == provider.dataDiklat.length) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.06,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      provider.tambahDiklat();
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.black,
                                    ))
                              ],
                            ),
                          );
                        } else {
                          return CustomItemComponentWidget(
                            controller: provider.dataDiklat[index].data,
                            code: 4,
                            index: index,
                            provider: provider,
                            hintTitle: "Masukkan Nama Diklat",
                            title: "Diklat ${index + 1}",
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
            ],
          ),
        );
      }),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.06,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.1,
              vertical: MediaQuery.of(context).size.height * 0.005),
          child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.blueAccent),
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))))),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(
                        "Apakah Anda Yakin Ingin Menambahkan Pegawai Ini",
                        style: GoogleFonts.nunito(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                      title: Text(
                        "Perhatian",
                        style: GoogleFonts.nunito(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Cancel",
                              style: GoogleFonts.nunito(
                                  fontSize: 18,
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.w600),
                            )),
                        Consumer<TambahKaryawanProvider>(
                            builder: (context, provider, child) {
                          return provider.isLoading
                              ? CircularProgressIndicator()
                              : TextButton(
                                  onPressed: () async {
                                    if (await provider.tambahPegawaiFinal(
                                        context
                                            .read<AuthProvider>()
                                            .adminModel!
                                            .idAdmin)) {
                                      log("Berhasil");
                                      Fluttertoast.showToast(msg: "Berhasil");
                                      Navigator.pop(context);
                                    } else {
                                      log("Gagal");
                                      Fluttertoast.showToast(msg: "Gagal");
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Text(
                                    "Ok",
                                    style: GoogleFonts.nunito(
                                        fontSize: 18,
                                        color: Colors.blueAccent,
                                        fontWeight: FontWeight.w600),
                                  ));
                        })
                      ],
                    );
                  },
                );
              },
              child: Text(
                "Tambah Pegawai",
                style: GoogleFonts.nunito(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              )),
        ),
      ),
    );
  }
}