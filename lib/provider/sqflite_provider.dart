import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:simpeg/data/host_data.dart';
import 'package:simpeg/models/pangkat_golongan_model.dart';
import 'package:simpeg/models/pegawai_detail_model.dart';
import 'package:simpeg/models/pegawai_get_model.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteProvider extends ChangeNotifier {
  List<PegawaiDetailModel> pegawai = [];

  List<PegawaiGetModel> pegawaiSqlite = [];
  bool isLoading = false;
  Database? db;
  Future<bool> initilizeDatabase() async {
    isLoading = true;
    notifyListeners();
    // Get a location using getDatabasesPath
    db = await openDatabase('pegawai.db');
    if (db == null) {
      print("Database Belum diinisiais");
      isLoading = false;
      notifyListeners();
      return false;
    } else {
      print("database path : ${db!.database}");
      await createTable();
      if (await sysncronized()) {
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

  Future<bool> initilizeDatabaseWithoutSysn() async {
    isLoading = true;
    // Get a location using getDatabasesPath
    db = await openDatabase('pegawai.db');
    if (db == null) {
      print("Database Belum diinisiais");
      isLoading = false;
      return false;
    } else {
      print("database path : ${db!.database}");
      
      await createTable();
      isLoading = false;
      return true;
    }
  }

  Future<List<ConnectivityResult>> checkKoneksi() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    return connectivityResult;
  }

  Future<void> dropValue() async {
    await db!.delete('tbl_pegawai');
    print("Done");
    notifyListeners();
  }

  Future<void> createTable() async {
    await db!.execute('''
    CREATE TABLE IF NOT EXISTS tbl_pegawai (
      id_pegawai  INTEGER PRIMARY KEY AUTOINCREMENT,
      nama_pegawai TEXT NOT NULL,
      old_nip TEXT NOT NULL,
      new_nip TEXT NOT NULL,
      foto TEXT,
      jenis_kelamin TEXT CHECK (jenis_kelamin IN ('Laki-Laki','Perempuan')) NOT NULL,
      tempat_lahir TEXT NOT NULL,
      tanggal_lahir DATE NOT NULL,
      golongan TEXT CHECK (golongan IN ('2A','2B','2C','2D','3A','3B','3C','3D','4A','4B','4C','4D','4E')) NOT NULL,
      pendidikan TEXT CHECK (pendidikan IN ('SMA','D3','D4','S1','S2','S3')) NOT NULL,
      jabatan TEXT NOT NULL,
      pengalaman_jabatan TEXT NOT NULL,
      is_valid BOOLEAN NOT NULL DEFAULT 0
    )
  ''');
    await db!.execute('''
    CREATE TABLE IF NOT EXISTS tbl_sertifikat_pegawai (
      id_sertifikat INTEGER PRIMARY KEY AUTOINCREMENT,
      id_pegawai INTEGER NOT NULL,
      sertifikat TEXT NOT NULL,
      foto TEXT,
      FOREIGN KEY (id_pegawai) REFERENCES tbl_pegawai(id_pegawai) ON DELETE CASCADE
    )
  ''');

    await db!.execute('''
    CREATE TABLE IF NOT EXISTS tbl_diklat_pegawai (
      id_diklat INTEGER PRIMARY KEY AUTOINCREMENT,
      id_pegawai INTEGER NOT NULL,
      diklat TEXT NOT NULL,
      foto TEXT,
      FOREIGN KEY (id_pegawai) REFERENCES tbl_pegawai(id_pegawai) ON DELETE CASCADE
    )
  ''');

    await db!.execute('''
    CREATE TABLE IF NOT EXISTS tbl_kelebihan_pegawai (
      id_kelebihan INTEGER PRIMARY KEY AUTOINCREMENT,
      id_pegawai INTEGER NOT NULL,
      kelebihan TEXT NOT NULL,
      FOREIGN KEY (id_pegawai) REFERENCES tbl_pegawai(id_pegawai) ON DELETE CASCADE
    )
  ''');

    await db!.execute('''
    CREATE TABLE IF NOT EXISTS tbl_kekurangan_pegawai (
      id_kekurangan INTEGER PRIMARY KEY AUTOINCREMENT,
      id_pegawai INTEGER NOT NULL,
      kekurangan TEXT NOT NULL,
      FOREIGN KEY (id_pegawai) REFERENCES tbl_pegawai(id_pegawai) ON DELETE CASCADE
    )
  ''');
  }

  Future<void> insertPegawai(Map<String, dynamic> pegawaiData) async {
    await db!.insert(
      'tbl_pegawai',
      pegawaiData,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertPegawaiKelebihan(Map<String, dynamic> pegawaiData) async {
    await db!.insert(
      'tbl_kelebihan_pegawai',
      pegawaiData,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertPegawaiKekurangan(Map<String, dynamic> pegawaiData) async {
    await db!.insert(
      'tbl_kekurangan_pegawai',
      pegawaiData,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertPegawaiDiklat(Map<String, dynamic> pegawaiData) async {
    await db!.insert(
      'tbl_diklat_pegawai',
      pegawaiData,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertPegawaiSertifikat(Map<String, dynamic> pegawaiData) async {
    await db!.insert(
      'tbl_sertifikat_pegawai',
      pegawaiData,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> exampleInsert() async {
    Map<String, dynamic> pegawai = {
      'nama_pegawai': 'John Doe',
      'old_nip': '123456789012',
      'new_nip': '1234567890123456789012345',
      'foto': null,
      'jenis_kelamin': 'L',
      'tempat_lahir': 'Jakarta',
      'tanggal_lahir': '1980-01-01',
      'golongan': '3A',
      'pendidikan': 'S1',
      'jabatan': 'Manager',
      'pengalaman_jabatan': '10 years',
      'is_valid': 1,
    };

    await insertPegawai(pegawai);

    var data = await db!.query('tbl_pegawai');

    print(data);
    print(data[0]['id_pegawai']);
  }

  Future<bool> sysncronized() async {
    pegawai = await getAllPegawaiDetailForDss();
    await dropValue();
    try {
      for (var i = 0; i < pegawai.length; i++) {
        Map<String, dynamic> pegawaiMap = {
          'nama_pegawai': pegawai[i].namaPegawai,
          'old_nip': pegawai[i].oldNip,
          'new_nip': pegawai[i].newNip,
          'foto': pegawai[i].foto,
          'jenis_kelamin': pegawai[i].jenisKelamin,
          'tempat_lahir': pegawai[i].tempatLahir,
          'tanggal_lahir': pegawai[i].tanggalLahir,
          'golongan': pegawai[i].golongan,
          'pendidikan': pegawai[i].pendidikan,
          'jabatan': pegawai[i].jabatan,
          'pengalaman_jabatan': pegawai[i].pengalamanJabatan,
          'is_valid': 1,
        };
        insertPegawai(pegawaiMap);
        final List<Map<String, dynamic>> result = await db!
            .rawQuery('SELECT MAX(id_pegawai) as lastId FROM tbl_pegawai');

        var idPegawai = result[0]['lastId'];

        for (var j = 0; j < pegawai[i].certificates.length; j++) {
          Map<String, dynamic> sertifikatMap = {
            'id_pegawai': idPegawai,
            'sertifikat': pegawai[i].certificates[j].namaSertifikat,
          };
          insertPegawaiSertifikat(sertifikatMap);
        }
        for (var j = 0; j < pegawai[i].diklat.length; j++) {
          Map<String, dynamic> diklatMap = {
            'id_pegawai': idPegawai,
            'diklat': pegawai[i].diklat[j].diklat,
          };
          insertPegawaiDiklat(diklatMap);
        }
        for (var j = 0; j < pegawai[i].kelebihan.length; j++) {
          Map<String, dynamic> kelebihanMap = {
            'id_pegawai': idPegawai,
            'kelebihan': pegawai[i].kelebihan[j].kelebihan,
          };
          insertPegawaiKelebihan(kelebihanMap);
        }
        for (var j = 0; j < pegawai[i].kekurangan.length; j++) {
          Map<String, dynamic> kekuranganMap = {
            'id_pegawai': idPegawai,
            'kekurangan': pegawai[i].kekurangan[j].kekurangan,
          };
          insertPegawaiKekurangan(kekuranganMap);
        }
      }
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<PegawaiDetailModel> getPegawaiDetailOff(int idPegawai) async {
    List<SertifikatDetailModel> sertifikatPegawai = [];
    List<DiklatGetModel> diklatPegawai = [];
    List<KelebihanGetModel> kelebihanPegawai = [];
    List<KekurangannGetModel> kekuranganPegawai = [];
    var dataPegawai = await db!
        .query('tbl_pegawai', where: 'id_pegawai = ?', whereArgs: [idPegawai]);
    var dataKelebihanPegawai = await db!.query('tbl_kelebihan_pegawai',
        where: 'id_pegawai = ?', whereArgs: [idPegawai]);
    var dataKekuranganPegawai = await db!.query('tbl_kekurangan_pegawai',
        where: 'id_pegawai = ?', whereArgs: [idPegawai]);
    var dataDiklatPegawai = await db!.query('tbl_diklat_pegawai',
        where: 'id_pegawai = ?', whereArgs: [idPegawai]);
    var dataSertifikatPegawai = await db!.query('tbl_sertifikat_pegawai',
        where: 'id_pegawai = ?', whereArgs: [idPegawai]);

    print("Ini Data Pegawai ${dataPegawai}");
    print("Ini Data Kelebihan Pegawai ${dataKelebihanPegawai}");
    print("Ini Data Kekurangan Pegawai ${dataKekuranganPegawai}");
    print("Ini Data Diklat Pegawai ${dataDiklatPegawai}");
    print("Ini Data Sertifikat Pegawai ${dataSertifikatPegawai}");

    for (var i = 0; i < dataKelebihanPegawai.length; i++) {
      kelebihanPegawai
          .add(KelebihanGetModel.getDataFromJSON(dataKelebihanPegawai[i]));
    }

    for (var i = 0; i < dataSertifikatPegawai.length; i++) {
      sertifikatPegawai
          .add(SertifikatDetailModel.getDataFromJSON(dataSertifikatPegawai[i]));
    }
    for (var i = 0; i < dataDiklatPegawai.length; i++) {
      diklatPegawai.add(DiklatGetModel.getDataFromJSON(dataDiklatPegawai[i]));
    }
    for (var i = 0; i < dataKekuranganPegawai.length; i++) {
      kekuranganPegawai
          .add(KekurangannGetModel.getDataFromJSON(dataKekuranganPegawai[i]));
    }

    PegawaiGetModel pegawaiGetModel =
        PegawaiGetModel.getDataFromJSON(dataPegawai[0]);
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
      if (element.golongan == pegawaiGetModel.golongan) {
        pangkat = element.pangkat;
        break;
      }
    }
    PegawaiDetailModel pegawaiDetailModel = PegawaiDetailModel(
        idPegawai: idPegawai,
        oldNip: pegawaiGetModel.oldNip,
        newNip: pegawaiGetModel.newNip,
        namaPegawai: pegawaiGetModel.namaPegawai,
        foto: pegawaiGetModel.foto,
        jenisKelamin: pegawaiGetModel.jenisKelamin,
        tempatLahir: pegawaiGetModel.tempatLahir,
        tanggalLahir: pegawaiGetModel.tanggalLahir,
        pangkat: pangkat,
        golongan: pegawaiGetModel.golongan,
        pendidikan: pegawaiGetModel.pendidikan,
        jabatan: pegawaiGetModel.jabatan,
        pengalamanJabatan: pegawaiGetModel.pengalamanJabatan,
        certificates: sertifikatPegawai,
        kelebihan: kelebihanPegawai,
        kekurangan: kekuranganPegawai,
        diklat: diklatPegawai);
    return pegawaiDetailModel;
  }

  Future<List<PegawaiGetModel>> getAllPegawaiOff() async {
    pegawaiSqlite = [];
    var data = await db!.query('tbl_pegawai');
    for (var i = 0; i < data.length; i++) {
      pegawaiSqlite.add(PegawaiGetModel.getDataFromJSON(data[i]));
    }
    return pegawaiSqlite;
  }

  Future<List<PegawaiDetailModel>> getAllPegawaiDetailForDss() async {
    List<PegawaiDetailModel> allPegawai = [];

    try {
      var response =
          await http.get(Uri.parse("${hostData}/pegawai/detail/all"));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        List<dynamic> jsonMapping = (jsonData as Map<String, dynamic>)['data'];
        print(jsonMapping);
        for (var element in jsonMapping) {
          allPegawai.add(PegawaiDetailModel.getDataFromJSON(element));
        }
        return allPegawai;
      } else {
        return allPegawai;
      }
    } catch (e) {
      print(e);
      return allPegawai;
    }
  }
}
