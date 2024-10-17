class ChatModel {
  final int idChat;
  final String messsage;
  final String sender;
  final String sendAt;

  ChatModel(
      {required this.idChat,
      required this.messsage,
      required this.sendAt,
      required this.sender});

  factory ChatModel.getDataFromJSON(Map<String, dynamic> json) {
    return ChatModel(
        idChat: json['id_chat'] ?? 0,
        messsage: json['message'] ?? '',
        sendAt: json['send_at'] ?? '',
        sender: json['sender'] ?? '');
  }
}
