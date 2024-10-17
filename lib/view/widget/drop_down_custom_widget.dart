import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simpeg/provider/tambah_karyawan_provider.dart';



class DropDownCustomWidget extends StatefulWidget {
  final String title;
  final String hintDataa;
  final List<String> data;
  final String dataValue;
  final TambahKaryawanProvider provider;
  final int code;
  const DropDownCustomWidget(
      {super.key,
      required this.dataValue,
      required this.code,
      required this.data,
      required this.provider,
      required this.hintDataa,
      required this.title});

  @override
  State<DropDownCustomWidget> createState() => _DropDownCustomWidgetState();
}

class _DropDownCustomWidgetState extends State<DropDownCustomWidget> {
  String? values;
  @override
  void initState() {
    if (widget.code == 1) {
      values = widget.provider.jenisKelamin;
    } else if (widget.code == 2) {
      values = widget.provider.golongan;
    } else {
      values = widget.provider.pendidikanTerakhir;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.01),
      child: Container(
        margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.002,
            bottom: MediaQuery.of(context).size.height * 0.002),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.1,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.04,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.title,
                  style: GoogleFonts.nunito(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Expanded(
                child: Container(
              child: Padding(
                padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.3),
                child: DropdownButton(
                  value: widget.dataValue,
                  menuMaxHeight: MediaQuery.of(context).size.height * 0.15,
                  alignment: Alignment.centerLeft,
                  elevation: 10,
                  dropdownColor: const Color.fromRGBO(180, 197, 224, 1),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  isExpanded: true,
                  hint: Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.005),
                    child: Text(widget.hintDataa),
                  ),
                  onChanged: (valuetest) {
                    if (widget.code == 1) {
                      widget.provider.changeGender(valuetest!);
                    } else if (widget.code == 2) {
                      widget.provider.changeGolongan(valuetest!);
                    } else {
                      widget.provider.changePendidikan(valuetest!);
                    }
                    setState(() {});
                  },
                  items:
                      widget.data.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                        value: value, child: Text(value));
                  }).toList(),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}