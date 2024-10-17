class PegawaiModel {
  final int idAdmin;
  final int oldNip;
  final int newNip;
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

  PegawaiModel(
      {required this.foto,
      required this.golongan,
      required this.idAdmin,
      required this.jabatan,
      required this.jenisKelamin,
      required this.namaPegawai,
      required this.newNip,
      required this.oldNip,
      required this.pangkat,
      required this.pendidikan,
      required this.pengalamanJabatan,
      required this.tanggalLahir,
      required this.tempatLahir});
}
