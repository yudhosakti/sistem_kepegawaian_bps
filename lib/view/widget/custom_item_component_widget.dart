import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simpeg/provider/tambah_karyawan_provider.dart';

class CustomItemComponentWidget extends StatelessWidget {
  final String title;
  final int code;
  final TextEditingController controller;
  final String hintTitle;
  final int index;
  final TambahKaryawanProvider provider;
  const CustomItemComponentWidget(
      {super.key,
      required this.hintTitle,
      required this.controller,
      required this.title,
      required this.code,
      required this.index,
      required this.provider});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.01,
          vertical: MediaQuery.of(context).size.height * 0.005),
      child: Card(
        color: Color.fromRGBO(247, 247, 247, 1),
        elevation: 5,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.12,
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.12,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: IconButton(
                      iconSize: 32,
                      onPressed: () {
                        if (code == 1) {
                          provider.hapusSertifikat(index);
                        } else if (code == 2) {
                          provider.hapusKelebihant(index);
                        } else if (code == 3) {
                          provider.hapusKekurangan(index);
                        } else {
                          provider.hapusDiklat(index);
                        }
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
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.04,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                title,
                                style: GoogleFonts.nunito(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          Expanded(
                              child: Padding(
                            padding: EdgeInsets.only(
                                right:
                                    MediaQuery.of(context).size.width * 0.15),
                            child: Container(
                              child: TextFormField(
                                controller: controller,
                                decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: "Masukkan Nama Sertifikat",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                    disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)))),
                              ),
                            ),
                          ))
                        ],
                      ),
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