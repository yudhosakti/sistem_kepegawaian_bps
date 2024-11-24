import 'package:flutter/material.dart';
import 'package:simpeg/data/admin_data.dart';
import 'package:simpeg/models/admin_model.dart';

class DetailUserProvider extends ChangeNotifier {
  TextEditingController etEditField = TextEditingController();
  AdminModel? adminModel;
  String value = '';
  List<String> pickedData = ["Admin", "Staff", "User"];

  void setField(String data) {
    etEditField.text = data;
  }

  void setAdminModel(AdminModel newAdmin) {
    adminModel = newAdmin;
  }

  void changeValue(String data) {
    value = data;
    notifyListeners();
  }

  Future<bool> updateField(
      int code, int idUser, String email, String username, String role) async {
    AdminModel? adminData;
    if (code == 1) {
      adminData =
          await AdminData().updateUser(idUser, etEditField.text, email, role);
    } else if (code == 2) {
      adminData =
          await AdminData().updateUser(idUser, username, etEditField.text, role);
    } else {
      adminData =
          await AdminData().updateUser(idUser, username, email, value);
    }

    if (adminData == null) {
      return false;
    } else {
      setAdminModel(adminData);
      notifyListeners();
      return true;
    }
  }
}
