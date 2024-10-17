import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simpeg/provider/gemini_chat_provider.dart';

class EmployeePickWidget extends StatelessWidget {
  const EmployeePickWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<GeminiChatProvider>(builder: (context, provider, child) {
        return Card(
          color: Color.fromRGBO(237, 229, 228, 1),
          elevation: 10,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.95,
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: BoxDecoration(),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.08,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(121, 102, 255, 1),
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(12))),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.02),
                      child: Text(
                        "Pick Employee",
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                              padding:
                                  WidgetStatePropertyAll(EdgeInsets.all(8)),
                              shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8)))),
                              backgroundColor: WidgetStatePropertyAll(
                                Colors.blueAccent,
                              )),
                          onPressed: () {
                            provider.selectAllPegawai();
                          },
                          child: Text(
                            "Select All",
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          )),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                              padding:
                                  WidgetStatePropertyAll(EdgeInsets.all(8)),
                              shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8)))),
                              backgroundColor: WidgetStatePropertyAll(
                                Colors.redAccent,
                              )),
                          onPressed: () {
                            provider.resetAllPegawai();
                          },
                          child: Text(
                            "Deselect All",
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          )),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    child: GridView.builder(
                      itemCount: provider.allPegawai.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              provider.pictPegawai(index);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  color: provider.isPicked[index]
                                      ? Colors.blueAccent
                                      : Colors.white),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    height: 1,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.08,
                                    decoration: BoxDecoration(
                                        image: provider
                                                    .allPegawai[index].foto ==
                                                ''
                                            ? DecorationImage(
                                                image: AssetImage(
                                                    'assets/default_profile.jpg'))
                                            : DecorationImage(
                                                image: NetworkImage(provider
                                                    .allPegawai[index].foto)),
                                        color: Colors.grey,
                                        shape: BoxShape.circle),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width *
                                                0.03),
                                    child: Center(
                                      child: Text(
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        provider.allPegawai[index].namaPegawai,
                                        style: GoogleFonts.poppins(
                                            color: provider.isPicked[index]
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width *
                                                0.03),
                                    child: Text(
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        provider.allPegawai[index].jabatan,
                                        style: GoogleFonts.poppins(
                                            color: provider.isPicked[index]
                                                ? Colors.white
                                                : Colors.black)),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
