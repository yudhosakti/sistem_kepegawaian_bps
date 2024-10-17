import 'package:simpeg/models/pangkat_golongan_model.dart';

class PegawaiGetModel {
  final int idPegawai;
  final String oldNip;
  final String newNip;
  final String namaPegawai;
  final String foto;
  final String jenisKelamin;
  final String tempatLahir;
  final String tanggalLahir;
  final String pangkat;
  final String golongan;
  final String pendidikan;
  final String jabatan;
  final String pengalamanJabatan;
  PegawaiGetModel(
      {required this.foto,
      required this.golongan,
      required this.pengalamanJabatan,
      required this.idPegawai,
      required this.jabatan,
      required this.jenisKelamin,
      required this.namaPegawai,
      required this.newNip,
      required this.oldNip,
      required this.pangkat,
      required this.pendidikan,
      required this.tanggalLahir,
      required this.tempatLahir});

  factory PegawaiGetModel.getDataFromJSON(Map<String, dynamic> json) {
    String pangkat = "Pengatur Muda";
    List<PangkatGolonganModel> pangkatList = [
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

    for (var element in pangkatList) {
      if (element.golongan == json['golongan']) {
        pangkat = element.pangkat;
        break;
      }
    }
    return PegawaiGetModel(
        foto: json['foto'] ?? '',
        golongan: json['golongan'] ?? '',
        idPegawai: json['id_pegawai'] ?? 0,
        jabatan: json['jabatan'] ?? '',
        jenisKelamin: json['jenis_kelamin'] ?? '',
        namaPegawai: json['nama_pegawai'] ?? '',
        newNip: json['new_nip'] ?? 0,
        oldNip: json['old_nip'] ?? 0,
        pangkat: pangkat,
        pendidikan: json['pendidikan'] ?? '',
        tanggalLahir: json['tanggal_lahir'] ?? '',
        tempatLahir: json['tempat_lahir'] ?? '',
        pengalamanJabatan: json['pengalaman_jabatan'] ?? '');
  }

}
