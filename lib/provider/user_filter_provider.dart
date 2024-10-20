import 'package:flutter/material.dart';
import 'package:simpeg/data/admin_data.dart';
import 'package:simpeg/models/admin_model.dart';

class UserFilterProvider extends ChangeNotifier {
  bool isExpanded = false;

  String filterValue = "Role";

  String value = "Admin";

  List<AdminModel> adminModels = [];

  List<AdminModel> adminFilter = [];

  List<String> pickedData = ["Admin", "Staff", "User"];

  List<String> filter = ["Role"];

  void changeFilterValue(String value) {
    filterValue = value;
    changeList(pickedData);

    notifyListeners();
  }

  void filterAdmin() {
    adminFilter = [];
    for (var element in adminModels) {
      if (element.role == value) {
        adminFilter.add(element);
      }
    }
    notifyListeners();
  }

  void initialData(List<AdminModel> admins, int idAdmin) {
    adminModels = [];
    for (var element in admins) {
      if (element.idAdmin != idAdmin) {
        adminModels.add(element);
      }
    }
    adminFilter = adminModels;
  }

  void changeList(List<String> listData) {
    pickedData = listData;
    value = pickedData[0];
    print(value);
  }

  void changeValue(String value1) {
    value = value1;
    print(value);
    notifyListeners();
  }

  void changeExpandedValue() {
    isExpanded = !isExpanded;
    notifyListeners();
  }

  void resetFilter() {
    adminFilter = adminModels;
    notifyListeners();
  }

  Future<void> deleteUser(int index, int idAdmin) async {
    if (await AdminData().updateStatusAdmin(adminFilter[index].idAdmin)) {
      adminModels = await AdminData().getAllUser();
      initialData(adminModels, idAdmin);
      notifyListeners();
    } else {
      adminFilter = adminModels;
      notifyListeners();
    }
  }
}
