import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:simpeg/data/admin_data.dart';
import 'package:simpeg/models/admin_model.dart';

class AuthProvider extends ChangeNotifier {
  TextEditingController etEmailLogin = TextEditingController();
  TextEditingController etPasswordLogin = TextEditingController();
  TextEditingController etUsernameRegister = TextEditingController();
  TextEditingController etEmailRegister = TextEditingController();
  TextEditingController etPasswordRegister = TextEditingController();
  TextEditingController etConfirmPasswordRegister = TextEditingController();

  bool passwordLogin = true;
  bool passwordRegister = true;
  bool passwordConfirmRegister = true;

  AdminModel? adminModel;
  String errorMessage = '';

  bool validateLogin() {
    errorMessage = '';
    if (etEmailLogin.text.isEmpty || etPasswordLogin.text.isEmpty) {
      errorMessage = "Email dan Password Harus Diisi";
      return false;
    } else {
      return true;
    }
  }

  bool validateRegister() {
    errorMessage = '';
    if (etUsernameRegister.text.isEmpty ||
        etEmailRegister.text.isEmpty ||
        etPasswordRegister.text.isEmpty ||
        etConfirmPasswordRegister.text.isEmpty) {
      errorMessage = "Semua Field Harus Diisi";
      return false;
    } else if (etConfirmPasswordRegister.text != etPasswordRegister.text) {
      errorMessage = "Password tidak match";
      return false;
    } else {
      return true;
    }
  }

  void changeObsCure(int code) {
    if (code == 1) {
      passwordLogin = !passwordLogin;
    } else if (code == 2) {
      passwordRegister = !passwordRegister;
    } else {
      passwordConfirmRegister = !passwordConfirmRegister;
    }
    notifyListeners();
  }

  Future<bool> loginUser() async {
    if (validateLogin()) {
      await AdminData().loginUser(etEmailLogin.text, etPasswordLogin.text).then(
        (value) {
          if (value != null) {
            adminModel = value;
          }
        },
      );
      if (adminModel != null) {
        return true;
      } else {
        errorMessage = "Invalid Email Or Password";
        return false;
      }
    } else {
      return false;
    }
  }

  void updateUserInformation(AdminModel newAdmin) {
    adminModel = newAdmin;
    notifyListeners();
  }

  Future<bool> registerUser() async {
    if (validateRegister()) {
      if (await AdminData().registerUser(etEmailRegister.text,
          etUsernameRegister.text, etPasswordRegister.text)) {
        return true;
      } else {
        errorMessage = 'Internal Error';
        return false;
      }
    } else {
      return false;
    }
  }

  void resetUser() {
    adminModel = null;
  }
}
