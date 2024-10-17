import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simpeg/data/admin_data.dart';
import 'package:simpeg/models/admin_model.dart';

class AddUserProvider extends ChangeNotifier {
  String value = "Staff";
  List<String> pickedData = ["Admin", "Staff", "User"];

  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  final ImagePicker imagePicker = ImagePicker();
  bool isLoading = false;
  File? fileImage;
  XFile? platformFile;
  String image = "";

  Future<bool> addUser() async {
    isLoading = true;
    notifyListeners();
    if (validateText()) {
      if (fileImage != null) {
        image = fileImage!.path;
      }
      AdminModel adminModel = AdminModel(
          avatar: image,
          email: email.text,
          password: password.text,
          idAdmin: 0,
          lastLogin: '',
          role: value,
          username: username.text);

      if (await AdminData().addUser(adminModel)) {
        isLoading = false;
        notifyListeners();
        return true;
      } else {
        isLoading = false;
        notifyListeners();
        return false;
      }
    } else {
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> takePickture() async {
    try {
      XFile? result = await imagePicker.pickImage(source: ImageSource.gallery);
      if (result == null) {
        return false;
      } else {
        platformFile = result;
        fileImage = File(platformFile!.path);
        log(fileImage!.path);
        notifyListeners();
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  void changeValue(String newValue) {
    value = newValue;
    notifyListeners();
  }

  bool validateText() {
    if (username.text.isEmpty || email.text.isEmpty || password.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
}
