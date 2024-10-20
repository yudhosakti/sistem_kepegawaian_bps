import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simpeg/data/decision_data.dart';
import 'package:simpeg/models/decision_model.dart';
import 'package:simpeg/provider/auth_provider.dart';
import 'package:simpeg/provider/gemini_chat_provider.dart';
import 'package:simpeg/view/pages/chat_ai_page.dart';
import 'package:simpeg/view/pages/detail_pegawai_page.dart';
import 'package:simpeg/view/pages/search_employee_page.dart';

class AiWidget extends StatelessWidget {
  const AiWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(121, 102, 255, 1),
        title: Text(
          "Decision Support System",
          style: GoogleFonts.mulish(
              color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: context.read<AuthProvider>().adminModel!.role == 'Admin'
          ? ListView(
              children: [
                SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.005,
                              vertical:
                                  MediaQuery.of(context).size.height * 0.004),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.42,
                            height: MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(69, 80, 237, 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(18))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical:
                                          MediaQuery.of(context).size.height *
                                              0.006),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                    height: MediaQuery.of(context).size.height,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle),
                                    child: Center(
                                      child: Consumer<GeminiChatProvider>(
                                          builder: (context, provider, child) {
                                        return IconButton(
                                            padding: EdgeInsets.zero,
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                      "Buat Chat Baru",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color:
                                                                  Colors.black),
                                                    ),
                                                    content: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.08,
                                                      child: TextFormField(
                                                        controller: provider
                                                            .etTitleChat,
                                                        decoration: InputDecoration(
                                                            border: OutlineInputBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            12))),
                                                            hintText:
                                                                "Masukkan Judul Chat",
                                                            fillColor:
                                                                Colors.white,
                                                            filled: true),
                                                      ),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(
                                                            "Cancel",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    color: Colors
                                                                        .redAccent),
                                                          )),
                                                      TextButton(
                                                          onPressed: () async {
                                                            if (provider
                                                                .titleLoading) {
                                                              print("Loading");
                                                            } else {
                                                              int idDecision = await provider
                                                                  .createDecision(context
                                                                      .read<
                                                                          AuthProvider>()
                                                                      .adminModel!
                                                                      .idAdmin);
                                                              if (idDecision !=
                                                                  0) {
                                                                print(
                                                                    idDecision);
                                                                Navigator.pop(
                                                                    context);
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                  builder:
                                                                      (context) {
                                                                    return ChatAiPage(
                                                                      idDecision:
                                                                          idDecision,
                                                                    );
                                                                  },
                                                                ));
                                                              } else {
                                                                Fluttertoast
                                                                    .showToast(
                                                                        msg:
                                                                            "Failed");
                                                              }
                                                            }
                                                          },
                                                          child: Text(
                                                            "Create",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    color: Colors
                                                                        .blueAccent),
                                                          ))
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            icon: Icon(
                                              Icons.add,
                                              size: 42,
                                              color: Colors.black,
                                            ));
                                      }),
                                    ),
                                  ),
                                ),
                                Text(
                                  "New Chat",
                                  style: GoogleFonts.mulish(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.03,
                                )
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.search,
                              size: 32,
                              color: Colors.black,
                            ))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    "All Chat",
                    style: GoogleFonts.mulish(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                ),
                FutureBuilder(
                    future: DecisionData().getAllDecisionByIdUser(
                        context.read<AuthProvider>().adminModel!.idAdmin),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return LoadingWidget();
                      } else if (snapshot.data!.isEmpty) {
                        return NoDataWidget();
                      } else {
                        List<DecisionModel> dataDecision = snapshot.data!;
                        return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: dataDecision.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.01,
                                  vertical: MediaQuery.of(context).size.height *
                                      0.01),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return ChatAiPage(
                                          idDecision:
                                              dataDecision[index].idDecision);
                                    },
                                  ));
                                },
                                child: Card(
                                  color: Colors.blueAccent,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  elevation: 5,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    constraints: BoxConstraints(
                                        minHeight:
                                            MediaQuery.of(context).size.height *
                                                0.1,
                                        maxHeight: double.infinity),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.005,
                                          bottom: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1,
                                            constraints: BoxConstraints(
                                                minHeight:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.1,
                                                maxHeight: double.infinity),
                                            child: Center(
                                              child: Icon(
                                                Icons.message,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                              child: Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  dataDecision[index].title,
                                                  style: GoogleFonts.mulish(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                Text(
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  dataDecision[index]
                                                              .lastChat ==
                                                          ''
                                                      ? "No History Chat"
                                                      : dataDecision[index]
                                                          .lastChat,
                                                  style: GoogleFonts.mulish(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                          ))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    })
              ],
            )
          : Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.01),
                child: Text(
                  "Hanya Admin yang bisa menggunakan fitur ini ",
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
              ),
            ),
    );
  }
}
