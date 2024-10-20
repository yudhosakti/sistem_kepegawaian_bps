import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:simpeg/data/decision_data.dart';
import 'package:simpeg/models/chat_model.dart';
import 'package:simpeg/models/pegawai_detail_model.dart';

class GeminiChatProvider extends ChangeNotifier {
  List<PegawaiDetailModel> allPegawai = [];

  List<PegawaiDetailModel> pickedPegawai = [];

  List<ChatModel> listChat = [];

  List<Map<String, dynamic>> mappingPegawai = [];

  List<bool> isPicked = [];

  TextEditingController etMessage = TextEditingController();

  TextEditingController etTitleChat = TextEditingController();

  bool isLoading = false;

  bool titleLoading = false;

  void initialPicked() {
    isPicked = [];
    for (var i = 0; i < allPegawai.length; i++) {
      isPicked.add(false);
    }
  }

  void resetChat() {
    etMessage.text = '';
    etTitleChat.text = '';
  }

  bool validateTitle() {
    if (etTitleChat.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<int> createDecision(int idAdmin) async {
    if (validateTitle()) {
      titleLoading = true;
      notifyListeners();
      int idData = await DecisionData().addDecision(idAdmin, etTitleChat.text);
      if (idData != 0) {
        titleLoading = false;
        notifyListeners();
        return idData;
      } else {
        return 0;
      }
    } else {
      return 0;
    }
  }

  void pictPegawai(int index) {
    isPicked[index] = !isPicked[index];
    pickedPegawai = [];

    for (var i = 0; i < allPegawai.length; i++) {
      if (isPicked[i]) {
        pickedPegawai.add(allPegawai[i]);
      }
    }
    print(pickedPegawai);
    notifyListeners();
  }

  void selectAllPegawai() {
    pickedPegawai = [];
    initialPicked();
    for (var i = 0; i < allPegawai.length; i++) {
      pickedPegawai.add(allPegawai[i]);
      isPicked[i] = true;
    }
    print(pickedPegawai);
    notifyListeners();
  }

  void resetAllPegawai() {
    pickedPegawai = [];
    initialPicked();

    notifyListeners();
  }

  Future<void> addChat(String message, String sendAt, int idDecision) async {
    if (validateText()) {
      isLoading = true;
      informationEmployee();
      listChat.add(ChatModel(
          idChat: 1, messsage: message, sendAt: sendAt, sender: "User"));
      listChat.add(ChatModel(
          idChat: -99,
          messsage: 'AI Sedang mengetik pesan',
          sendAt: sendAt,
          sender: "AI"));

      notifyListeners();

      final prompt =
          "saya mempunya data : ${mappingPegawai}  \n pertanyaan : ${message}";

      ChatModel aiChat = await DecisionData()
          .addDecisionChat(idDecision, 'User', message, prompt);
      resetChat();
      listChat.remove(listChat.last);
      listChat.add(aiChat);
      isLoading = false;
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: "Pesan Tidak Boleh Kosong");
    }
  }

  bool validateText() {
    if (etMessage.text.trim().isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  void informationEmployee() {
    mappingPegawai = [];
    for (var i = 0; i < pickedPegawai.length; i++) {
      mappingPegawai.add(pickedPegawai[i].toMap());
    }

    print(mappingPegawai);
  }

  void initialPegawai(List<PegawaiDetailModel> pegawaiNew) {
    allPegawai = pegawaiNew;
  }

  void initialChat(List<ChatModel> newChat) {
    listChat = newChat;
  }
}
