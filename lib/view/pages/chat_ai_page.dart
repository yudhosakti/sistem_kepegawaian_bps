import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:simpeg/data/decision_data.dart';
import 'package:simpeg/data/pegawai_data.dart';
import 'package:simpeg/provider/gemini_chat_provider.dart';
import 'package:simpeg/view/widget/employee_pick_widget.dart';

class ChatAiPage extends StatelessWidget {
  final int idDecision;
  const ChatAiPage({super.key, required this.idDecision});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: PegawaiData().getAllPegawaiDetailForDss(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              appBar: null,
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.data!.isEmpty) {
            return Scaffold(
              appBar: null,
              body: Center(
                  child: Text(
                "No Data Pegawai",
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 20),
              )),
            );
          } else {
            context.read<GeminiChatProvider>().initialPegawai(snapshot.data!);
            return Scaffold(
              backgroundColor: Color.fromRGBO(241, 238, 252, 1),
              appBar: AppBar(
                backgroundColor: Color.fromRGBO(121, 102, 255, 1),
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    )),
                title: Text(
                  "Chat AI",
                  style: GoogleFonts.mulish(color: Colors.white),
                ),
              ),
              body: FutureBuilder(
                  future: DecisionData().getAllDecisionChat(idDecision),
                  builder: (context, snapshot) {
                    print("Rebuild");
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }else {
                      context
                          .read<GeminiChatProvider>()
                          .initialChat(snapshot.data!);
                      return Consumer<GeminiChatProvider>(
                          builder: (context, provider, child) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.005),
                          child: provider.listChat.isNotEmpty ? ListView(
                            children: [
                               ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: provider.listChat.length,
                                itemBuilder: (context, index) {
                                  if (provider.listChat[index].sender !=
                                      'User') {
                                    return AiChatBoxWidget(
                                      message:
                                          provider.listChat[index].messsage,
                                      sendAt: provider.listChat[index].sendAt,
                                    );
                                  } else {
                                    return UserChatWidget(
                                      message:
                                          provider.listChat[index].messsage,
                                      sendAt: provider.listChat[index].sendAt,
                                    );
                                  }
                                },
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                              )
                            ],
                          ) : Center(child: Text("No Chat Yet",style: GoogleFonts.poppins(
                            color: Colors.black,fontWeight: FontWeight.w500,
                            fontSize: 16
                          ),),),
                        );
                      });
                    }
                  }),
              bottomSheet: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.08,
                color: Colors.white,
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.22,
                      height: MediaQuery.of(context).size.height,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                              onPressed: () {
                                if (context
                                    .read<GeminiChatProvider>()
                                    .isPicked
                                    .isEmpty) {
                                  context
                                      .read<GeminiChatProvider>()
                                      .initialPicked();
                                }
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return EmployeePickWidget();
                                  },
                                );
                              },
                              icon: Icon(
                                Icons.group,
                                color: Colors.black,
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.image,
                                color: Colors.black,
                              ))
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.65,
                      height: MediaQuery.of(context).size.height,
                      child: Center(
                        child: Consumer<GeminiChatProvider>(
                            builder: (context, provider, child) {
                          return TextFormField(
                            controller: provider.etMessage,
                            style: GoogleFonts.mulish(color: Colors.black),
                            decoration: InputDecoration(
                                hintText: "Masukkan Pesan",
                                hintStyle:
                                    GoogleFonts.mulish(color: Colors.black),
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(18)))),
                          );
                        }),
                      ),
                    ),
                    Expanded(child: Container(
                      child: Center(
                        child: Consumer<GeminiChatProvider>(
                            builder: (context, provider, child) {
                          return IconButton(
                              onPressed: () {
                                if (provider.isLoading) {
                                  print("Loading");
                                } else {
                                  DateTime dateformat =
                                      DateFormat('yyyy-MM-DD HH:mm')
                                          .parse(DateTime.now().toString());
                                  String dateString =
                                      "${dateformat.year}-${dateformat.month}-${dateformat.day} ${dateformat.hour}:${dateformat.minute}";
                                  provider.addChat(
                                      provider.etMessage.text, dateString,idDecision);
                                }
                              },
                              icon: Icon(
                                Icons.send,
                                color: Colors.black,
                              ));
                        }),
                      ),
                    ))
                  ],
                ),
              ),
            );
          }
        });
  }
}

class AiChatBoxWidget extends StatefulWidget {
  final String message;
  final String sendAt;
  const AiChatBoxWidget(
      {super.key, required this.message, required this.sendAt});

  @override
  State<AiChatBoxWidget> createState() => _AiChatBoxWidgetState();
}

class _AiChatBoxWidgetState extends State<AiChatBoxWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.01,
          vertical: MediaQuery.of(context).size.height * 0.005),
      child: Container(
        width: MediaQuery.of(context).size.width,
        constraints: BoxConstraints(maxHeight: double.infinity, minHeight: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.6,
                  minWidth: MediaQuery.of(context).size.width * 0.005,
                  minHeight: 0,
                  maxHeight: double.infinity),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.01,
                    vertical: MediaQuery.of(context).size.height * 0.005),
                child: widget.message.length > 250
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            maxLines: isExpanded ? 999 : 10,
                            widget.message.replaceAll('*', ''),
                            style: GoogleFonts.mulish(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ),
                          TextButton(
                              onPressed: () {
                                isExpanded = !isExpanded;
                                setState(() {});
                              },
                              child: isExpanded
                                  ? Text("Lihat Lebih Sedikit")
                                  : Text('Lihat Selengkapnya'))
                        ],
                      )
                    : Text(
                        maxLines: isExpanded ? 999 : 10,
                        widget.message,
                        style: GoogleFonts.mulish(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Padding(
              padding: EdgeInsets.only(left: 4),
              child: Text(
                widget.sendAt,
                style: GoogleFonts.mulish(
                    color: Colors.black, fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class UserChatWidget extends StatelessWidget {
  final String message;
  final String sendAt;
  const UserChatWidget(
      {super.key, required this.message, required this.sendAt});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.01,
          vertical: MediaQuery.of(context).size.height * 0.005),
      child: Container(
        width: MediaQuery.of(context).size.width,
        constraints: BoxConstraints(maxHeight: double.infinity, minHeight: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.6,
                  minWidth: MediaQuery.of(context).size.width * 0.005,
                  minHeight: 0,
                  maxHeight: double.infinity),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.01,
                    vertical: MediaQuery.of(context).size.height * 0.005),
                child: Text(
                  message,
                  style: GoogleFonts.mulish(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Padding(
              padding: EdgeInsets.only(left: 4),
              child: Text(
                sendAt,
                style: GoogleFonts.mulish(
                    color: Colors.black, fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}
