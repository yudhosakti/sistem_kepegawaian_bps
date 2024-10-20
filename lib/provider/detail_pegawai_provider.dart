import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simpeg/data/pegawai_data.dart';
import 'package:simpeg/data/pegawai_identity_data.dart';
import 'package:simpeg/models/pangkat_golongan_model.dart';
import 'package:simpeg/models/pegawai_detail_model.dart';
import 'package:simpeg/models/pegawai_get_model.dart';

class DetailPegawaiProvider extends ChangeNotifier {
  PegawaiDetailModel? pegawaiDetailModel;
  List<PangkatGolonganModel> pangkatGolongan = [
    PangkatGolonganModel(golongan: "2A", pangkat: "Pengatur Muda"),
    PangkatGolonganModel(golongan: "2B", pangkat: "Pengatur Muda Tingkat 1"),
    PangkatGolonganModel(golongan: "2C", pangkat: "Pengatur"),
    PangkatGolonganModel(golongan: "2D", pangkat: "Pengatur Tingkat 1"),
    PangkatGolonganModel(golongan: "3A", pangkat: "Penata Muda"),
    PangkatGolonganModel(golongan: "3B", pangkat: "Penata Muda Tingkat 1"),
    PangkatGolonganModel(golongan: "3C", pangkat: "Penata"),
    PangkatGolonganModel(golongan: "3D", pangkat: "Penata Tingkat 1"),
    PangkatGolonganModel(golongan: "4A", pangkat: "Pembina"),
    PangkatGolonganModel(golongan: "4B", pangkat: "Pembina Tingkat 1"),
    PangkatGolonganModel(golongan: "4C", pangkat: "Pembina Utama Muda"),
    PangkatGolonganModel(golongan: "4D", pangkat: "Pembina Utama Madya"),
    PangkatGolonganModel(golongan: "4E", pangkat: "Pembina Utama")
  ];

  TextEditingController etEditField = TextEditingController();
  TextEditingController etEditOtherField = TextEditingController();
  TextEditingController etUpdateOtherField = TextEditingController();
  bool isLoadinhg = false;
  final ImagePicker imagePicker = ImagePicker();
  File? fileImage;
  XFile? platformFile;

  void setInitialPegawai(PegawaiDetailModel newPegawai) {
    pegawaiDetailModel = newPegawai;
  }

  Future<bool> updatePegawai(int code, int idAdmin) async {
    setLoading(true);
    if (code == 1) {
      if (await PegawaiData().updatePegawai(
          PegawaiGetModel(
              foto: '',
              golongan: pegawaiDetailModel!.golongan,
              pengalamanJabatan: pegawaiDetailModel!.pengalamanJabatan,
              idPegawai: pegawaiDetailModel!.idPegawai,
              jabatan: pegawaiDetailModel!.jabatan,
              jenisKelamin:
                  pegawaiDetailModel!.jenisKelamin == 'Laki-Laki' ? 'L' : 'P',
              namaPegawai: etEditField.text,
              newNip: pegawaiDetailModel!.newNip,
              oldNip: pegawaiDetailModel!.oldNip,
              pangkat: pegawaiDetailModel!.pangkat,
              pendidikan: pegawaiDetailModel!.pendidikan,
              tanggalLahir: pegawaiDetailModel!.tanggalLahir,
              tempatLahir: pegawaiDetailModel!.tempatLahir),
          idAdmin)) {
        setLoading(false);
        return true;
      } else {
        setLoading(false);
        return false;
      }
    } else if (code == 2) {
      if (await PegawaiData().updatePegawai(
          PegawaiGetModel(
              foto: '',
              golongan: pegawaiDetailModel!.golongan,
              pengalamanJabatan: pegawaiDetailModel!.pengalamanJabatan,
              idPegawai: pegawaiDetailModel!.idPegawai,
              jabatan: pegawaiDetailModel!.jabatan,
              jenisKelamin:
                  pegawaiDetailModel!.jenisKelamin == 'Laki-Laki' ? 'L' : 'P',
              namaPegawai: pegawaiDetailModel!.namaPegawai,
              newNip: etEditField.text,
              oldNip: pegawaiDetailModel!.oldNip,
              pangkat: pegawaiDetailModel!.pangkat,
              pendidikan: pegawaiDetailModel!.pendidikan,
              tanggalLahir: pegawaiDetailModel!.tanggalLahir,
              tempatLahir: pegawaiDetailModel!.tempatLahir),
          idAdmin)) {
        setLoading(false);
        return true;
      } else {
        setLoading(false);
        return false;
      }
    } else if (code == 3) {
      if (await PegawaiData().updatePegawai(
          PegawaiGetModel(
              foto: '',
              golongan: pegawaiDetailModel!.golongan,
              pengalamanJabatan: pegawaiDetailModel!.pengalamanJabatan,
              idPegawai: pegawaiDetailModel!.idPegawai,
              jabatan: pegawaiDetailModel!.jabatan,
              jenisKelamin:
                  pegawaiDetailModel!.jenisKelamin == 'Laki-Laki' ? 'L' : 'P',
              namaPegawai: pegawaiDetailModel!.namaPegawai,
              newNip: pegawaiDetailModel!.newNip,
              oldNip: etEditField.text,
              pangkat: pegawaiDetailModel!.pangkat,
              pendidikan: pegawaiDetailModel!.pendidikan,
              tanggalLahir: pegawaiDetailModel!.tanggalLahir,
              tempatLahir: pegawaiDetailModel!.tempatLahir),
          idAdmin)) {
        setLoading(false);
        return true;
      } else {
        setLoading(false);
        return false;
      }
    } else if (code == 4) {
      if (await PegawaiData().updatePegawai(
          PegawaiGetModel(
              foto: '',
              golongan: pegawaiDetailModel!.golongan,
              pengalamanJabatan: pegawaiDetailModel!.pengalamanJabatan,
              idPegawai: pegawaiDetailModel!.idPegawai,
              jabatan: pegawaiDetailModel!.jabatan,
              jenisKelamin: etEditField.text == 'Laki-Laki' ? 'L' : 'P',
              namaPegawai: pegawaiDetailModel!.namaPegawai,
              newNip: pegawaiDetailModel!.newNip,
              oldNip: pegawaiDetailModel!.oldNip,
              pangkat: pegawaiDetailModel!.pangkat,
              pendidikan: pegawaiDetailModel!.pendidikan,
              tanggalLahir: pegawaiDetailModel!.tanggalLahir,
              tempatLahir: pegawaiDetailModel!.tempatLahir),
          idAdmin)) {
        setLoading(false);
        return true;
      } else {
        setLoading(false);
        return false;
      }
    } else if (code == 5) {
      if (await PegawaiData().updatePegawai(
          PegawaiGetModel(
              foto: '',
              golongan: pegawaiDetailModel!.golongan,
              pengalamanJabatan: pegawaiDetailModel!.pengalamanJabatan,
              idPegawai: pegawaiDetailModel!.idPegawai,
              jabatan: pegawaiDetailModel!.jabatan,
              jenisKelamin:
                  pegawaiDetailModel!.jenisKelamin == 'Laki-Laki' ? 'L' : 'P',
              namaPegawai: pegawaiDetailModel!.namaPegawai,
              newNip: pegawaiDetailModel!.newNip,
              oldNip: pegawaiDetailModel!.oldNip,
              pangkat: pegawaiDetailModel!.pangkat,
              pendidikan: pegawaiDetailModel!.pendidikan,
              tanggalLahir: pegawaiDetailModel!.tanggalLahir,
              tempatLahir: etEditField.text),
          idAdmin)) {
        setLoading(false);
        return true;
      } else {
        setLoading(false);
        return false;
      }
    } else if (code == 6) {
      if (await PegawaiData().updatePegawai(
          PegawaiGetModel(
              foto: '',
              golongan: pegawaiDetailModel!.golongan,
              pengalamanJabatan: pegawaiDetailModel!.pengalamanJabatan,
              idPegawai: pegawaiDetailModel!.idPegawai,
              jabatan: pegawaiDetailModel!.jabatan,
              jenisKelamin:
                  pegawaiDetailModel!.jenisKelamin == 'Laki-Laki' ? 'L' : 'P',
              namaPegawai: pegawaiDetailModel!.namaPegawai,
              newNip: pegawaiDetailModel!.newNip,
              oldNip: pegawaiDetailModel!.oldNip,
              pangkat: pegawaiDetailModel!.pangkat,
              pendidikan: pegawaiDetailModel!.pendidikan,
              tanggalLahir: etEditField.text,
              tempatLahir: pegawaiDetailModel!.tempatLahir),
          idAdmin)) {
        setLoading(false);
        return true;
      } else {
        setLoading(false);
        return false;
      }
    } else if (code == 7) {
      String pangkat = 'Penata Muda';
      for (var element in pangkatGolongan) {
        if (etEditField.text == element.golongan) {
          pangkat = element.pangkat;
          break;
        }
      }
      if (await PegawaiData().updatePegawai(
          PegawaiGetModel(
              foto: '',
              golongan: etEditField.text,
              pengalamanJabatan: pegawaiDetailModel!.pengalamanJabatan,
              idPegawai: pegawaiDetailModel!.idPegawai,
              jabatan: pegawaiDetailModel!.jabatan,
              jenisKelamin:
                  pegawaiDetailModel!.jenisKelamin == 'Laki-Laki' ? 'L' : 'P',
              namaPegawai: pegawaiDetailModel!.namaPegawai,
              newNip: pegawaiDetailModel!.newNip,
              oldNip: pegawaiDetailModel!.oldNip,
              pangkat: pangkat,
              pendidikan: pegawaiDetailModel!.pendidikan,
              tanggalLahir: pegawaiDetailModel!.tanggalLahir,
              tempatLahir: pegawaiDetailModel!.tempatLahir),
          idAdmin)) {
        setLoading(false);
        return true;
      } else {
        setLoading(false);
        return false;
      }
    } else if (code == 9) {
      if (await PegawaiData().updatePegawai(
          PegawaiGetModel(
              foto: '',
              golongan: pegawaiDetailModel!.golongan,
              pengalamanJabatan: pegawaiDetailModel!.pengalamanJabatan,
              idPegawai: pegawaiDetailModel!.idPegawai,
              jabatan: pegawaiDetailModel!.jabatan,
              jenisKelamin:
                  pegawaiDetailModel!.jenisKelamin == 'Laki-Laki' ? 'L' : 'P',
              namaPegawai: pegawaiDetailModel!.namaPegawai,
              newNip: pegawaiDetailModel!.newNip,
              oldNip: pegawaiDetailModel!.oldNip,
              pangkat: pegawaiDetailModel!.pangkat,
              pendidikan: etEditField.text,
              tanggalLahir: pegawaiDetailModel!.tanggalLahir,
              tempatLahir: pegawaiDetailModel!.tempatLahir),
          idAdmin)) {
        setLoading(false);
        return true;
      } else {
        setLoading(false);
        return false;
      }
    } else if (code == 10) {
      if (await PegawaiData().updatePegawai(
          PegawaiGetModel(
              foto: '',
              golongan: pegawaiDetailModel!.golongan,
              pengalamanJabatan: pegawaiDetailModel!.pengalamanJabatan,
              idPegawai: pegawaiDetailModel!.idPegawai,
              jabatan: etEditField.text,
              jenisKelamin:
                  pegawaiDetailModel!.jenisKelamin == 'Laki-Laki' ? 'L' : 'P',
              namaPegawai: pegawaiDetailModel!.namaPegawai,
              newNip: pegawaiDetailModel!.newNip,
              oldNip: pegawaiDetailModel!.oldNip,
              pangkat: pegawaiDetailModel!.pangkat,
              pendidikan: pegawaiDetailModel!.pendidikan,
              tanggalLahir: pegawaiDetailModel!.tanggalLahir,
              tempatLahir: pegawaiDetailModel!.tempatLahir),
          idAdmin)) {
        setLoading(false);
        return true;
      } else {
        setLoading(false);
        return false;
      }
    } else if (code == 11) {
      if (await PegawaiData().updatePegawai(
          PegawaiGetModel(
              foto: '',
              golongan: pegawaiDetailModel!.golongan,
              pengalamanJabatan: etEditField.text,
              idPegawai: pegawaiDetailModel!.idPegawai,
              jabatan: pegawaiDetailModel!.jabatan,
              jenisKelamin:
                  pegawaiDetailModel!.jenisKelamin == 'Laki-Laki' ? 'L' : 'P',
              namaPegawai: pegawaiDetailModel!.namaPegawai,
              newNip: pegawaiDetailModel!.newNip,
              oldNip: pegawaiDetailModel!.oldNip,
              pangkat: pegawaiDetailModel!.pangkat,
              pendidikan: pegawaiDetailModel!.pendidikan,
              tanggalLahir: pegawaiDetailModel!.tanggalLahir,
              tempatLahir: pegawaiDetailModel!.tempatLahir),
          idAdmin)) {
        setLoading(false);
        return true;
      } else {
        setLoading(false);
        return false;
      }
    } else {
      isLoadinhg = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> getPegawaiDetail(int idPegawai) async {
    pegawaiDetailModel = await PegawaiData().getDetailPegawai(idPegawai);
    notifyListeners();
    if (pegawaiDetailModel != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> createNewBehavior(int code, int idAdmin) async {
    if (validateField()) {
      if (code == 1) {
        if (await PegawaiData().tambahSertifikatPegawai(
            pegawaiDetailModel!.idPegawai, idAdmin, etEditOtherField.text)) {
          if (await getPegawaiDetail(pegawaiDetailModel!.idPegawai)) {
            return true;
          } else {
            return false;
          }
        } else {
          return false;
        }
      } else if (code == 2) {
        if (await PegawaiData().tambahKelebihanPegawai(
            pegawaiDetailModel!.idPegawai, idAdmin, etEditOtherField.text)) {
          if (await getPegawaiDetail(pegawaiDetailModel!.idPegawai)) {
            return true;
          } else {
            return false;
          }
        } else {
          return false;
        }
      } else if (code == 3) {
        if (await PegawaiData().tambahKekuranganPegawai(
            pegawaiDetailModel!.idPegawai, idAdmin, etEditOtherField.text)) {
          if (await getPegawaiDetail(pegawaiDetailModel!.idPegawai)) {
            return true;
          } else {
            return false;
          }
        } else {
          return false;
        }
      } else if (code == 4) {
        if (await PegawaiData().tambahDiklatPegawai(
            pegawaiDetailModel!.idPegawai, idAdmin, etEditOtherField.text)) {
          if (await getPegawaiDetail(pegawaiDetailModel!.idPegawai)) {
            return true;
          } else {
            return false;
          }
        } else {
          return false;
        }
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  bool validateField() {
    if (etEditOtherField.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> deleteNewBehavior(int code, int idItem) async {
    if (code == 1) {
      if (await PegawaiIdentityData().deleteSertifikat(idItem)) {
        if (await getPegawaiDetail(pegawaiDetailModel!.idPegawai)) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } else if (code == 2) {
      if (await PegawaiIdentityData().deleteKelebihan(idItem)) {
        if (await getPegawaiDetail(pegawaiDetailModel!.idPegawai)) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } else if (code == 3) {
      if (await PegawaiIdentityData().deleteKekurangan(idItem)) {
        if (await getPegawaiDetail(pegawaiDetailModel!.idPegawai)) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } else if (code == 4) {
      if (await PegawaiIdentityData().deleteDiklat(idItem)) {
        if (await getPegawaiDetail(pegawaiDetailModel!.idPegawai)) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> updateNewBehavior(
      int code, int idItem, int idAdmin, String newField) async {
    if (validateUpdateItem()) {
      if (code == 1) {
        if (await PegawaiIdentityData()
            .updateSertifikat(idItem, idAdmin, newField)) {
          if (await getPegawaiDetail(pegawaiDetailModel!.idPegawai)) {
            return true;
          } else {
            return false;
          }
        } else {
          return false;
        }
      } else if (code == 2) {
        if (await PegawaiIdentityData()
            .updateKelebihant(idItem, idAdmin, newField)) {
          if (await getPegawaiDetail(pegawaiDetailModel!.idPegawai)) {
            return true;
          } else {
            return false;
          }
        } else {
          return false;
        }
      } else if (code == 3) {
        if (await PegawaiIdentityData()
            .updateKekurangan(idItem, idAdmin, newField)) {
          if (await getPegawaiDetail(pegawaiDetailModel!.idPegawai)) {
            return true;
          } else {
            return false;
          }
        } else {
          return false;
        }
      } else if (code == 4) {
        if (await PegawaiIdentityData()
            .updateDiklat(idItem, idAdmin, newField)) {
          if (await getPegawaiDetail(pegawaiDetailModel!.idPegawai)) {
            return true;
          } else {
            return false;
          }
        } else {
          return false;
        }
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  bool validateUpdateItem() {
    if (etUpdateOtherField.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void resetAll() {
    fileImage = null;
    platformFile = null;
  }

  Future<bool> takePickture() async {
    try {
      XFile? result = await imagePicker.pickImage(source: ImageSource.gallery);
      if (result == null) {
        return false;
      } else {
        platformFile = result;
        fileImage = File(platformFile!.path);
        print(fileImage!.path);
        if (await updateImageOnly()) {
          notifyListeners();
          return true;
        } else {
          notifyListeners();
          return false;
        }
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateImageOnly() async {
    if (await PegawaiData().updateProfilePegawaiOnly(
        fileImage!.path, pegawaiDetailModel!.idPegawai)) {
      return true;
    } else {
      return false;
    }
  }

  void resetBehavior() {
    etEditOtherField.text = '';
  }

  void setLoading(bool loaState) {
    isLoadinhg = loaState;
    notifyListeners();
  }
}
