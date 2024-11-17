import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simpeg/provider/auth_provider.dart';
import 'package:simpeg/provider/gemini_chat_provider.dart';

class ListItems extends StatelessWidget {
  final int idChat;
  final String title;
  const ListItems({super.key, required this.idChat, required this.title});

  @override
  Widget build(BuildContext context) {
    return Consumer<GeminiChatProvider>(builder: (context, provider, child) {
      provider.etEditChat.text = title;
      return Column(
        children: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        "Edit Judul Chat",
                        style: GoogleFonts.poppins(color: Colors.black),
                      ),
                      content: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.08,
                        child: TextFormField(
                          controller: provider.etEditChat,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              hintText: "Masukkan Judul Chat",
                              fillColor: Colors.white,
                              filled: true),
                        ),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Cancel",
                              style:
                                  GoogleFonts.poppins(color: Colors.redAccent),
                            )),
                        TextButton(
                            onPressed: () async {
                              if (await provider.updateDecisionTitle(
                                  idChat,
                                  context
                                      .read<AuthProvider>()
                                      .adminModel!
                                      .idAdmin)) {
                                Fluttertoast.showToast(msg: "Success");
                                Navigator.pop(context);
                              } else {
                                Fluttertoast.showToast(msg: "Failed");
                                Navigator.pop(context);
                              }
                            },
                            child: Text(
                              "Create",
                              style:
                                  GoogleFonts.poppins(color: Colors.blueAccent),
                            ))
                      ],
                    );
                  },
                );
              },
              child: Text("Update Title")),
          TextButton(
              onPressed: () async {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Konfirmasi Hapus Chat"),
                      content: Text("Apakah Anda Ingin Menghapus Chat Ini ?"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Cancel",
                              style:
                                  GoogleFonts.poppins(color: Colors.redAccent),
                            )),
                        TextButton(
                            onPressed: () async {
                              if (await provider.deleteDecision(
                                  idChat,
                                  context
                                      .read<AuthProvider>()
                                      .adminModel!
                                      .idAdmin)) {
                                Fluttertoast.showToast(msg: "Hapus Berhasil");
                                Navigator.pop(context);
                              } else {
                                Fluttertoast.showToast(msg: "Failed");
                                Navigator.pop(context);
                              }
                            },
                            child: Text(
                              "Ok",
                              style:
                                  GoogleFonts.poppins(color: Colors.blueAccent),
                            ))
                      ],
                    );
                  },
                );
              },
              child: Text("Delete"))
        ],
      );
    });
  }
}
