import 'package:flutter/material.dart';
import 'package:simpeg/data/pegawai_data.dart';
import 'package:simpeg/data/pegawai_identity_data.dart';
import 'package:simpeg/models/pegawai_validate_model.dart';

class ValidatePegawaiProvier extends ChangeNotifier {
  List<PegawaiValidateModel> pegawaiModel = [];

  void initialData(List<PegawaiValidateModel> newPegawai) {
    pegawaiModel = newPegawai;
  }

  void staffInitialData(List<PegawaiValidateModel> newPegawai, namaStaff) {
    pegawaiModel = [];
    for (var element in newPegawai) {
      if (element.createBy == namaStaff) {
        pegawaiModel.add(element);
      }
    }
  }

  Future<void> refreshList() async {
    pegawaiModel = await PegawaiData().getAllValidatePegawai();
    notifyListeners();
  }

  Future<bool> deleteSelectedPegawai(int index) async {
    if (await PegawaiIdentityData()
        .deletePegawai(pegawaiModel[index].idPegawai)) {
      refreshList();
      return true;
    } else {
      refreshList();
      return false;
    }
  }

  Future<bool> updateValidatePegawai(int index, int idAdmin) async {
    if (await PegawaiIdentityData()
        .updateValidityPegawai(idAdmin, pegawaiModel[index].idPegawai)) {
      refreshList();
      return true;
    } else {
      refreshList();
      return false;
    }
  }
}
