import 'package:flutter/material.dart';
import 'package:simpeg/data/pegawai_data.dart';
import 'package:simpeg/data/pegawai_identity_data.dart';
import 'package:simpeg/models/pegawai_get_model.dart';

class EmployeeFilterProvider extends ChangeNotifier {
  bool isExpanded = false;

  String filterValue = "Golongan";

  String value = "2A";

  List<PegawaiGetModel> pegawaiGetModel = [];
  List<PegawaiGetModel> filteredPegawai = [];

  List<String> pickedData = [
    "2A",
    "2B",
    "2C",
    "2D",
    "3A",
    "3B",
    "3C",
    "3D",
    "4A",
    "4B"
  ];

  List<String> ijazahTerakhir = ["SMA", "D1", "D2", "D3", "D4", "S1", "S2"];
  List<String> jenisKelamin = ["Laki-Laki", "Perempuan"];
  List<String> listGolonganKaryawan = [
    "2A",
    "2B",
    "2C",
    "2D",
    "3A",
    "3B",
    "3C",
    "3D",
    "4A",
    "4B"
  ];

  List<String> filter = ["Jenis Kelamin", "Golongan", "Pendidikan"];

  void initialPegawai(List<PegawaiGetModel> pegawai) {
    pegawaiGetModel = pegawai;
    filteredPegawai = pegawaiGetModel;
  }

  void changeFilterValue(String value) {
    filterValue = value;
    if (filterValue == 'Golongan') {
      changeList(listGolonganKaryawan);
    } else if (filterValue == 'Pendidikan') {
      changeList(ijazahTerakhir);
    } else {
      changeList(jenisKelamin);
    }

    notifyListeners();
  }

  void filterPegawai(String filteredValue) {
    filteredPegawai = [];
    if (filteredValue == 'Golongan') {
      for (var element in pegawaiGetModel) {
        if (element.golongan == value) {
          filteredPegawai.add(element);
        }
      }
    } else if (filterValue == 'Pendidikan') {
      for (var element in pegawaiGetModel) {
        if (element.pendidikan == value) {
          filteredPegawai.add(element);
        }
      }
    } else {
      for (var element in pegawaiGetModel) {
        if (element.jenisKelamin == value) {
          filteredPegawai.add(element);
        }
      }
    }
    notifyListeners();
  }

  Future<void> deleteSelectedPegawai(int index) async {
    await PegawaiIdentityData()
        .deletePegawai(pegawaiGetModel[index].idPegawai)
        .then(
      (value) async {
        pegawaiGetModel = await PegawaiData().getAllPegawai();
        filteredPegawai = pegawaiGetModel;
        notifyListeners();
      },
    );
  }

  void resetFilter() {
    filteredPegawai = pegawaiGetModel;
    notifyListeners();
  }

  void changeList(List<String> listData) {
    pickedData = listData;
    value = pickedData[0];
    print(value);
  }

  void changeValue(String value1) {
    value = value1;
    print(value);
  }

  void changeExpandedValue() {
    isExpanded = !isExpanded;
    notifyListeners();
  }
}
