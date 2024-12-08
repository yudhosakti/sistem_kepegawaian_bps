class LogModel {
  final int idLog;
  final int idUser;
  final String namaUser;
  final String role;
  final String message;
  final String status;
  final String createAt;

  LogModel(
      {required this.createAt,
      required this.idLog,
      required this.idUser,
      required this.message,
      required this.namaUser,
      required this.status,
      required this.role});

  factory LogModel.getDataFromJSON(Map<String, dynamic> json) {
    return LogModel(
        createAt: json['create_at'] ?? '',
        idLog: json['id_log'] ?? 0,
        message: json['message'] ?? '',
        idUser: json['id_user'] ?? 0,
        namaUser: json['username'] ?? '',
        status: json['status'] ?? '',
        role: json['role'] ?? '');
  }
}
