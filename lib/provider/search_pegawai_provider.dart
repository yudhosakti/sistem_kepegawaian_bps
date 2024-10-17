import 'package:flutter/material.dart';
import 'package:simpeg/data/pegawai_data.dart';
import 'package:simpeg/data/pegawai_identity_data.dart';
import 'package:simpeg/models/pegawai_get_model.dart';

class SearchPegawaiProvider extends ChangeNotifier {
  List<PegawaiGetModel> pegawaiList = [];

  TextEditingController etSearch = TextEditingController();

  bool isLoading = false;

  void getInitialPegawai(List<PegawaiGetModel> pegawai) {
    pegawaiList = pegawai;
  }

  Future<bool> getSearchPegawai() async {
    isLoading = true;
    notifyListeners();
    if (etSearch.text.isNotEmpty) {
      pegawaiList = await PegawaiData().getSearchPegawai(etSearch.text);
      isLoading = false;
      notifyListeners();
      return true;
    } else {
      pegawaiList = await PegawaiData().getAllPegawai();
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> getAllPegawai() async {
    pegawaiList = await PegawaiData().getAllPegawai();
  }

  Future<bool> deleteSelectedPegawai(int idPegawai) async {
    isLoading = true;
    notifyListeners();
    if (await PegawaiIdentityData().deletePegawai(idPegawai)) {
      await getAllPegawai();
      isLoading = false;
      notifyListeners();
      return true;
    } else {
      isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
