import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:simpeg/data/host_data.dart';
import 'package:simpeg/models/chat_model.dart';
import 'package:simpeg/models/decision_model.dart';

class DecisionData {
  Future<List<DecisionModel>> getAllDecisionByIdUser(int idUser) async {
    List<DecisionModel> allDecision = [];
    try {
      var response =
          await http.get(Uri.parse("${hostData}/decision?id_user=${idUser}"));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        List<dynamic> jsonMap = (jsonData as Map<String, dynamic>)['data'];
        for (var element in jsonMap) {
          allDecision.add(DecisionModel.getDataFromJSON(element));
        }
        return allDecision;
      } else {
        print(jsonDecode(response.body));
        return allDecision;
      }
    } catch (e) {
      print(e);
      return allDecision;
    }
  }

  Future<List<ChatModel>> getAllDecisionChat(int idDecision) async {
    List<ChatModel> allChat = [];
    try {
      var response = await http.get(
          Uri.parse("${hostData}/decision/chat?id_decision=${idDecision}"));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        List<dynamic> jsonMap = (jsonData as Map<String, dynamic>)['data'];
        for (var element in jsonMap) {
          allChat.add(ChatModel.getDataFromJSON(element));
        }
        return allChat;
      } else {
        return allChat;
      }
    } catch (e) {
      print(e);
      return allChat;
    }
  }

  Future<int> addDecision(int idAdmin, String title) async {
    try {
      var response = await http.post(Uri.parse("${hostData}/decision"),
          headers: {
            "Accept": "application/json",
            "content-type": "application/json",
          },
          body: jsonEncode({
            "id_admin": idAdmin,
            "title": title,
          }));
      print(response.body);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print(jsonData['id']);
        return jsonData['id'];
      } else {
        return 0;
      }
    } catch (e) {
      print(e);
      return 0;
    }
  }

  Future<ChatModel> addDecisionChat(
      int idDecision, String sender, String message, String prompt) async {
    ChatModel chat =
        ChatModel(idChat: 0, messsage: 'Error', sendAt: '', sender: 'AI');
    try {
      var response = await http.post(Uri.parse("${hostData}/decision/chat"),
          headers: {
            "Accept": "application/json",
            "content-type": "application/json",
          },
          body: jsonEncode({
            "id_decision": idDecision,
            "sender": sender,
            "message": message,
            "prompt": prompt
          }));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        chat = ChatModel.getDataFromJSON(jsonData['data']);
        return chat;
      } else {
        return chat;
      }
    } catch (e) {
      print(e);
      return chat;
    }
  }

  Future<bool> updateTitleDecision(int idDecision, String title) async {
    try {
      var response = await http.put(Uri.parse("${hostData}/decision"),
          headers: {
            "Accept": "application/json",
            "content-type": "application/json",
          },
          body: jsonEncode({
            "id_decision": idDecision,
            "title": title,
          }));
      if (response.statusCode == 200) {
        return true;
      } else {
        print(response.body);
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteDecision(int idDecision) async {
    try {
      var response = await http
          .delete(Uri.parse("${hostData}/decision?id_decision=${idDecision}"));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
