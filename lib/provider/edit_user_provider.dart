import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simpeg/data/admin_data.dart';
import 'package:simpeg/models/admin_model.dart';

class EditUserProvider extends ChangeNotifier {
  TextEditingController etUsername = TextEditingController();
  TextEditingController etEmail = TextEditingController();

  final ImagePicker imagePicker = ImagePicker();
  bool isLoading = false;
  File? fileImage;
  AdminModel? modelAdmin;
  XFile? platformFile;
  String image = "";

  Future<bool> takePickture() async {
    try {
      XFile? result = await imagePicker.pickImage(source: ImageSource.gallery);
      if (result == null) {
        return false;
      } else {
        platformFile = result;
        fileImage = File(platformFile!.path);
        notifyListeners();
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  void initialData(String usernameNow, String emailNow) {
    etUsername.text = usernameNow;
    etEmail.text = emailNow;
  }

  Future<bool> updateProfile(int idAdmin) async {
    isLoading = true;
    notifyListeners();
    if (validateInput()) {
      if (fileImage != null) {
        image = fileImage!.path;
      }
      AdminModel? test = await AdminData()
          .updateAdminProfile(idAdmin, image, etUsername.text, etEmail.text);
      if (test != null) {
        print(test.username);
        modelAdmin = test;
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

  bool validateInput() {
    if (etUsername.text.isEmpty || etEmail.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
}
