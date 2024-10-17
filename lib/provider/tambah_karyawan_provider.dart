import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simpeg/data/pegawai_data.dart';
import 'package:simpeg/models/data_custom_model.dart';
import 'package:simpeg/models/pangkat_golongan_model.dart';
import 'package:simpeg/models/pegawai_model.dart';
import 'package:simpeg/models/sertifikat_model.dart';

class TambahKaryawanProvider extends ChangeNotifier {
  List<SertifikatModel> test = [
    SertifikatModel(
        idPegawai: 1, image: '', namaSertifikat: TextEditingController())
  ];

  List<DataCustomModel> dataKelebihan = [
  ];
  List<DataCustomModel> dataKekurangan = [
  ];
  List<DataCustomModel> dataDiklat = [
    DataCustomModel(data: TextEditingController(), idPegawai: 1)
  ];

  List<String> dataGolongan = [
    "2A",
    "2B",
    "2C",
    "2D",
    "3A",
    "3B",
    "3C",
    "3D",
    "4A",
    "4B",
    "4C",
    "4D",
    "4E"
  ];

  List<String> dataJenisKelamin = ["Laki-Laki", "Perempuan"];
  List<String> dataPendidikan = ["SMA", "D3", "D4", "S1", "S2", "S3"];

  List<PangkatGolonganModel> pangkat = [
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

  TextEditingController namaPegawai = TextEditingController();
  TextEditingController OldNipPegawai = TextEditingController();

  TextEditingController NewNipPegawai = TextEditingController();
  TextEditingController pangkatPegawai = TextEditingController();

  TextEditingController TempatLahirPegawai = TextEditingController();
  String? tanggalLahir;
  String jenisKelamin = "Laki-Laki";
  String pickedGender = '';
  String golongan = "3A";
  String pickedPangkat = '';
  String pendidikanTerakhir = "S1";
  TextEditingController JabatanPegawai = TextEditingController();
  TextEditingController PengalamanPejabatPegawai = TextEditingController();
  Map<String, dynamic>? data;
  final ImagePicker imagePicker = ImagePicker();
  bool isLoading = false;
  File? fileImage;
  XFile? platformFile;

  Future<bool> tambahPegawaiFinal(int idAdmin) async {
    isLoading = true;
    notifyListeners();
    if (validate()) {
      if (jenisKelamin == "Laki-Laki") {
        pickedGender = 'L';
      } else {
        pickedGender = 'P';
      }
      String path = '';
      if (fileImage != null) {
        path = fileImage!.path;
      }

      PegawaiModel pegawaiModel = PegawaiModel(
          foto: path,
          golongan: golongan,
          pengalamanJabatan: PengalamanPejabatPegawai.text,
          idAdmin: idAdmin,
          jabatan: JabatanPegawai.text,
          jenisKelamin: pickedGender,
          namaPegawai: namaPegawai.text,
          newNip: int.parse(NewNipPegawai.text),
          oldNip: int.parse(OldNipPegawai.text),
          pangkat: pangkatPegawai.text,
          pendidikan: pendidikanTerakhir,
          tanggalLahir: tanggalLahir!,
          tempatLahir: TempatLahirPegawai.text);
      data = {
        "nama": namaPegawai.text,
        "gambar": fileImage == null ? '' : fileImage!.path,
        "oldNip": OldNipPegawai.text,
        "newNip": NewNipPegawai.text,
        "tempatLahir": TempatLahirPegawai.text,
        "tanggal_lahir": tanggalLahir,
        "jenis_kelamin": jenisKelamin,
        "gender": pickedGender,
        "pendidikan": pendidikanTerakhir,
        "jabatan": JabatanPegawai.text,
        "pengalamanPejabata": PengalamanPejabatPegawai.text,
        "pangkat": pickedPangkat,
        "sertifikar": test.toString(),
        "kelebihan": dataKelebihan.toString(),
        "kekurangan": dataKekurangan.toString(),
        "diklat": dataDiklat.toString()
      };
      print(pegawaiModel);
      int dataku = await PegawaiData().tambahPegawai(pegawaiModel, idAdmin);
      if (dataku != 0) {
        if (test.isNotEmpty) {
          for (var element in test) {
            await PegawaiData().tambahSertifikatPegawai(
                dataku, idAdmin, element.namaSertifikat.text);
          }
        }

        if (dataKelebihan.isNotEmpty) {
          for (var element in dataKelebihan) {
            await PegawaiData()
                .tambahKelebihanPegawai(dataku, idAdmin, element.data.text);
          }
        }
        if (dataKekurangan.isNotEmpty) {
          for (var element in dataKekurangan) {
            await PegawaiData()
                .tambahKekuranganPegawai(dataku, idAdmin, element.data.text);
          }
        }
        if (dataDiklat.isNotEmpty) {
          for (var element in dataDiklat) {
            await PegawaiData()
                .tambahDiklatPegawai(dataku, idAdmin, element.data.text);
          }
        }
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

  void changeGender(String newGender) {
    jenisKelamin = newGender;
    log(jenisKelamin);
    notifyListeners();
  }

  void changeTanggal(DateTime newTanggal) {
    DateTime dateFormat = newTanggal;
    tanggalLahir = "${dateFormat.year}-${dateFormat.month}-${dateFormat.day}";
    notifyListeners();
  }

  void changeGolongan(String newGolongan) {
    golongan = newGolongan;
    for (var element in pangkat) {
      if (golongan == element.golongan) {
        pangkatPegawai.text = element.pangkat;
        pickedPangkat = element.pangkat;
        break;
      }
    }
    notifyListeners();
  }

  void changePendidikan(String newPendidikan) {
    pendidikanTerakhir = newPendidikan;
    notifyListeners();
  }

  bool validate() {
    if (namaPegawai.text.isEmpty ||
        OldNipPegawai.text.isEmpty ||
        NewNipPegawai.text.isEmpty ||
        pangkatPegawai.text.isEmpty ||
        TempatLahirPegawai.text.isEmpty ||
        JabatanPegawai.text.isEmpty ||
        PengalamanPejabatPegawai.text.isEmpty) {
      return false;
    }
    for (var element in test) {
      if (element.namaSertifikat.text.isEmpty) {
        return false;
      }
    }
    for (var element in dataKelebihan) {
      if (element.data.text.isEmpty) {
        return false;
      }
    }
    for (var element in dataKekurangan) {
      if (element.data.text.isEmpty) {
        return false;
      }
    }
    for (var element in dataDiklat) {
      if (element.data.text.isEmpty) {
        return false;
      }
    }
    if (tanggalLahir == null || pickedPangkat == '') {
      return false;
    }
    return true;
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

  void tambahSertifikat() {
    test.add(SertifikatModel(
        idPegawai: 1, image: '', namaSertifikat: TextEditingController()));
    notifyListeners();
  }

  void hapusSertifikat(int index) {
    test.removeAt(index);
    notifyListeners();
  }

  void tambahKelebihan() {
    dataKelebihan
        .add(DataCustomModel(data: TextEditingController(), idPegawai: 1));
    notifyListeners();
  }

  void hapusKelebihant(int index) {
    dataKelebihan.removeAt(index);
    notifyListeners();
  }

  void tambahKekurangant() {
    dataKekurangan
        .add(DataCustomModel(data: TextEditingController(), idPegawai: 1));
    notifyListeners();
  }

  void hapusKekurangan(int index) {
    dataKekurangan.removeAt(index);
    notifyListeners();
  }

  void tambahDiklat() {
    dataDiklat
        .add(DataCustomModel(data: TextEditingController(), idPegawai: 1));
    notifyListeners();
  }

  void hapusDiklat(int index) {
    dataDiklat.removeAt(index);
    notifyListeners();
  }
}
