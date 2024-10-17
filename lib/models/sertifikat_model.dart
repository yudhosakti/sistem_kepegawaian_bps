import 'package:flutter/material.dart';

class SertifikatModel {
  int idPegawai;
  final TextEditingController namaSertifikat;
  final String image;

  SertifikatModel(
      {required this.idPegawai,
      required this.image,
      required this.namaSertifikat});
}
