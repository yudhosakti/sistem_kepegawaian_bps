import 'package:simpeg/models/pangkat_golongan_model.dart';

class PegawaiDetailModel {
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
  final List<SertifikatDetailModel> certificates;
  final List<KelebihanGetModel> kelebihan;
  final List<KekurangannGetModel> kekurangan;
  final List<DiklatGetModel> diklat;

  PegawaiDetailModel(
      {required this.idPegawai,
      required this.oldNip,
      required this.newNip,
      required this.namaPegawai,
      required this.foto,
      required this.jenisKelamin,
      required this.tempatLahir,
      required this.tanggalLahir,
      required this.pangkat,
      required this.golongan,
      required this.pendidikan,
      required this.jabatan,
      required this.pengalamanJabatan,
      required this.certificates,
      required this.kelebihan,
      required this.kekurangan,
      required this.diklat});

  factory PegawaiDetailModel.getDataFromJSON(Map<String, dynamic> json) {
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
    return PegawaiDetailModel(
        idPegawai: json['id_pegawai'] ?? 0,
        oldNip: json['old_nip'] ?? 0,
        newNip: json['new_nip'] ?? 0,
        namaPegawai: json['nama_pegawai'] ?? '',
        foto: json['foto'] ?? '',
        jenisKelamin: json['jenis_kelamin'] ?? '',
        tempatLahir: json['tempat_lahir'] ?? '',
        tanggalLahir: json['tanggal_lahir'] ?? '',
        pangkat: pangkat,
        golongan: json['golongan'] ?? '',
        pendidikan: json['pendidikan'] ?? '',
        jabatan: json['jabatan'] ?? '',
        pengalamanJabatan: json['pengalaman_jabatan'] ?? '',
        certificates: List<SertifikatDetailModel>.from(json['sertifikat']
            .map((x) => SertifikatDetailModel.getDataFromJSON(x))),
        kelebihan: List<KelebihanGetModel>.from(
            json['kelebihan'].map((x) => KelebihanGetModel.getDataFromJSON(x))),
        kekurangan: List<KekurangannGetModel>.from(json['kekurangan']
            .map((x) => KekurangannGetModel.getDataFromJSON(x))),
        diklat: List<DiklatGetModel>.from(
            json['diklat'].map((x) => DiklatGetModel.getDataFromJSON(x))));
  }

  Map<String, dynamic> toMap() {
    return {
      "namaPegawai": namaPegawai,
      "jenisKelamin": jenisKelamin,
      "tempatLahir": tempatLahir,
      "tanggalLahir": tanggalLahir,
      "pangkat": pangkat,
      "golongan": golongan,
      "pendidikan": pendidikan,
      "pengalamanJabatan": pengalamanJabatan,
      "sertifikat": certificates
          .map(
            (e) => e.toMap(),
          )
          .toList(),
      "kelebihan": kelebihan
          .map(
            (e) => e.toMap(),
          )
          .toList(),
      "kekurangan": kekurangan
          .map(
            (e) => e.toMap(),
          )
          .toList(),
      "diklat": diklat
          .map(
            (e) => e.toMap(),
          )
          .toList()
    };
  }
}

class SertifikatDetailModel {
  final int idSertifikat;
  final int idPegawai;
  final int idAdmin;
  final String namaSertifikat;
  final String buktiSertifikat;

  SertifikatDetailModel(
      {required this.buktiSertifikat,
      required this.idAdmin,
      required this.idPegawai,
      required this.idSertifikat,
      required this.namaSertifikat});

  factory SertifikatDetailModel.getDataFromJSON(Map<String, dynamic> json) {
    return SertifikatDetailModel(
        buktiSertifikat: json['bukti_sertifikat'] ?? '',
        idAdmin: json['id_user'] ?? 0,
        idPegawai: json['id_pegawai'] ?? 0,
        idSertifikat: json['id_sertifikat'] ?? 0,
        namaSertifikat: json['sertifikat'] ?? '');
  }

  Map<String, dynamic> toMap() {
    return {"namaSertifikat": namaSertifikat};
  }
}

class KelebihanGetModel {
  final int idKelebihan;
  final int idAdmin;
  final int idPegawai;
  final String kelebihan;

  KelebihanGetModel(
      {required this.idAdmin,
      required this.idKelebihan,
      required this.idPegawai,
      required this.kelebihan});
  factory KelebihanGetModel.getDataFromJSON(Map<String, dynamic> json) {
    return KelebihanGetModel(
        idAdmin: json['id_user'] ?? 0,
        idKelebihan: json['id_kelebihan'] ?? 0,
        idPegawai: json['id_pegawai'] ?? 0,
        kelebihan: json['kelebihan'] ?? '');
  }
  Map<String, dynamic> toMap() {
    return {"kelebihan": kelebihan};
  }
}

class KekurangannGetModel {
  final int idKekurangan;
  final int idAdmin;
  final int idPegawai;
  final String kekurangan;

  KekurangannGetModel(
      {required this.idAdmin,
      required this.idKekurangan,
      required this.idPegawai,
      required this.kekurangan});
  factory KekurangannGetModel.getDataFromJSON(Map<String, dynamic> json) {
    return KekurangannGetModel(
        idAdmin: json['id_user'] ?? 0,
        idKekurangan: json['id_kekurangan'] ?? 0,
        idPegawai: json['id_pegawai'] ?? 0,
        kekurangan: json['kekurangan'] ?? '');
  }
  Map<String, dynamic> toMap() {
    return {"kekurangan": kekurangan};
  }
}

class DiklatGetModel {
  final int idDiklat;
  final int idAdmin;
  final int idPegawai;
  final String diklat;

  DiklatGetModel(
      {required this.idAdmin,
      required this.diklat,
      required this.idPegawai,
      required this.idDiklat});
  factory DiklatGetModel.getDataFromJSON(Map<String, dynamic> json) {
    return DiklatGetModel(
        idAdmin: json['id_user'] ?? 0,
        idDiklat: json['id_diklat'] ?? 0,
        idPegawai: json['id_pegawai'] ?? 0,
        diklat: json['diklat'] ?? '');
  }
  Map<String, dynamic> toMap() {
    return {"diklat": diklat};
  }
}
