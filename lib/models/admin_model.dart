class AdminModel {
  final int idAdmin;
  String email;
  String username;
  final String role;
  final String password;
  final String avatar;
  final String lastLogin;
  String token = '';

  AdminModel(
      {required this.avatar,
      required this.email,
      required this.password,
      required this.idAdmin,
      required this.lastLogin,
      required this.role,
      required this.username});

  factory AdminModel.getDataFromJSON(Map<String, dynamic> json) {
    return AdminModel(
        avatar: json['avatar'] ?? '',
        email: json['email'] ?? '',
        idAdmin: json['id_user'] ?? 0,
        lastLogin: json['login_at'] ?? '',
        password: json['password'] ?? '',
        role: json['role'] ?? '',
        username: json['username'] ?? '');
  }

  Map<String, dynamic> toJSON() {
    return {"email": email, "username": username, "password": password};
  }
}
