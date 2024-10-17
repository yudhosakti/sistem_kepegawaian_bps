import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:simpeg/data/host_data.dart';

class PegawaiIdentityData {
  Future<bool> updateSertifikat(
      int idSertifikat, int idAdmin, String sertifikat) async {
    try {
      var response = await http.put(
        Uri.parse("${hostData}/certificate"),
        body: jsonEncode({
          "idSertifikat": idSertifikat,
          "nama_sertifikat": sertifikat,
          "id_admin": idAdmin
        }),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        print(response.body);
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updateKelebihant(
      int idKelebihan, int idAdmin, String kelebihan) async {
    try {
      var response = await http.put(
        Uri.parse("${hostData}/trait/kelebihan"),
        body: jsonEncode({
          "id_kelebihan": idKelebihan,
          "kelebihan": kelebihan,
          "idAdmin": idAdmin
        }),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        print(response.body);
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updateKekurangan(
      int idKekurangan, int idAdmin, String kekurangan) async {
    try {
      var response = await http.put(
        Uri.parse("${hostData}/trait/kekurangan"),
        body: jsonEncode({
          "id_kekurangan": idKekurangan,
          "kekurangan": kekurangan,
          "idAdmin": idAdmin
        }),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        print(response.body);
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updateDiklat(int idDiklat, int idAdmin, String diklat) async {
    try {
      var response = await http.put(
        Uri.parse("${hostData}/diklat"),
        body: jsonEncode(
            {"id_diklat": idDiklat, "diklat": diklat, "idAdmin": idAdmin}),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        print(response.body);
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteSertifikat(int idSertifikat) async {
    try {
      var response = await http.delete(
          Uri.parse("${hostData}/certificate?idSertifikat=${idSertifikat}"));

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteKelebihan(int idKelebihan) async {
    try {
      var response = await http.delete(
          Uri.parse("${hostData}/trait/kelebihan?id_kelebihan=${idKelebihan}"));

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteKekurangan(int idKekurangan) async {
    try {
      var response = await http.delete(Uri.parse(
          "${hostData}/trait/kekurangan?id_kekurangan=${idKekurangan}"));

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteDiklat(int idDiklat) async {
    try {
      var response = await http
          .delete(Uri.parse("${hostData}/diklat?id_diklat=${idDiklat}"));

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deletePegawai(int idPegawai) async {
    try {
      var response = await http
          .delete(Uri.parse("${hostData}/pegawai?id_pegawai=${idPegawai}"));
      if (response.statusCode == 200) {
        return true;
      } else {
        print(response.body);
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updateValidityPegawai(int idUser, int idPegawai) async {
    try {
      var response = await http.put(Uri.parse("${hostData}/pegawai/valid"),
          headers: {
            "Accept": "application/json",
            "content-type": "application/json",
          },
          body: jsonEncode({"id_user": idUser, "id_pegawai": idPegawai}));
      print(response.body);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
