class DecisionModel {
  final int idDecision;
  final int idUser;
  final String title;
  final String lastChat;
  final String createAt;

  DecisionModel(
      {required this.createAt,
      required this.idDecision,
      required this.idUser,
      required this.lastChat,
      required this.title});

  factory DecisionModel.getDataFromJSON(Map<String, dynamic> json) {
    return DecisionModel(
        createAt: json['create_at'] ?? '',
        idDecision: json['id_decision'] ?? 0,
        idUser: json['id_user'] ?? 0,
        lastChat: json['last_chat'] ?? '',
        title: json['title']);
  }
}
