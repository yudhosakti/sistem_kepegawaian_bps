import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simpeg/data/pegawai_data.dart';
import 'package:simpeg/provider/auth_provider.dart';
import 'package:simpeg/provider/employee_filter_provider.dart';
import 'package:simpeg/provider/sqflite_provider.dart';
import 'package:simpeg/view/pages/detail_pegawai_page.dart';

class ListEmployeePage extends StatefulWidget {
  ListEmployeePage({super.key});

  @override
  State<ListEmployeePage> createState() => _ListEmployeePageState();
}

class _ListEmployeePageState extends State<ListEmployeePage> {
  double getWidth() {
    FlutterView view = PlatformDispatcher.instance.views.first;

    double physicalWidth = view.physicalSize.width;

    double devicePixelRatio = view.devicePixelRatio;

    double screenWidth = physicalWidth / devicePixelRatio;
    return screenWidth;
  }

  double getHeight() {
    FlutterView view = PlatformDispatcher.instance.views.first;
    double physicalHeight = view.physicalSize.height;

    double devicePixelRatio = view.devicePixelRatio;
    double screenHeight = physicalHeight / devicePixelRatio;
    return screenHeight;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          backgroundColor: Colors.blueAccent,
          title: Text(
            "All Employee",
            style: GoogleFonts.mulish(
                color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
        body: ListView(
          children: [
            SizedBox(
              height: getHeight() * 0.01,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getWidth() * 0.01),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  constraints: BoxConstraints(maxHeight: double.infinity),
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(12))),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.058,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(57, 96, 164, 1),
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(8))),
                        child: Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: MediaQuery.of(context).size.height,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.01),
                                  child: Text(
                                    "Employee Filter",
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(child: Consumer<EmployeeFilterProvider>(
                                builder: (context, provider, child) {
                              return Container(
                                child: IconButton(
                                    alignment: Alignment.centerRight,
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width *
                                                0.01),
                                    onPressed: () {
                                      provider.changeExpandedValue();
                                    },
                                    icon: provider.isExpanded
                                        ? Icon(
                                            Icons.arrow_upward,
                                            color: Colors.white,
                                            size: 32,
                                          )
                                        : Icon(
                                            Icons.arrow_downward,
                                            color: Colors.white,
                                            size: 32,
                                          )),
                              );
                            }))
                          ],
                        ),
                      ),
                      Consumer<EmployeeFilterProvider>(
                          builder: (context, provider, chidl) {
                        return AnimatedSize(
                          duration: Duration(seconds: 1),
                          curve: Curves.fastOutSlowIn,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            constraints: provider.isExpanded
                                ? BoxConstraints()
                                : BoxConstraints(maxHeight: 0),
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(240, 223, 236, 1)),
                            child: Visibility(
                              visible: provider.isExpanded,
                              replacement: SizedBox.shrink(),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.01,
                                    vertical:
                                        MediaQuery.of(context).size.height *
                                            0.005),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: getHeight() * 0.01,
                                    ),
                                    Container(
                                      width: getWidth(),
                                      height: getHeight() * 0.06,
                                      child: Row(
                                        children: [
                                          Container(
                                            width: getWidth() * 0.48,
                                            height: getHeight(),
                                            child: Center(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        getWidth() * 0.01,
                                                    vertical:
                                                        getHeight() * 0.001),
                                                child: DropdownButtonFormField2<
                                                    String>(
                                                  value: provider.filterValue,
                                                  isExpanded: true,
                                                  decoration: InputDecoration(
                                                    fillColor: Colors.white,
                                                    filled: true,
                                                    // Add Horizontal padding using menuItemStyleData.padding so it matches
                                                    // the menu padding when button's width is not specified.
                                                    contentPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            vertical: 16),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                    // Add more decoration..
                                                  ),
                                                  hint: const Text(
                                                    'Select Filter',
                                                    style:
                                                        TextStyle(fontSize: 14),
                                                  ),
                                                  items: provider.filter
                                                      .map((item) =>
                                                          DropdownMenuItem<
                                                              String>(
                                                            value: item,
                                                            child: Text(
                                                              item,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ))
                                                      .toList(),
                                                  validator: (value) {
                                                    if (value == null) {
                                                      return 'Please select filter.';
                                                    }
                                                    return null;
                                                  },
                                                  onChanged: (value) {
                                                    if (value != null) {
                                                      provider
                                                          .changeFilterValue(
                                                              value);
                                                    }
                                                  },
                                                  onSaved: (value) {},
                                                  buttonStyleData:
                                                      const ButtonStyleData(
                                                    padding: EdgeInsets.only(
                                                        right: 8),
                                                  ),
                                                  iconStyleData:
                                                      const IconStyleData(
                                                    icon: Icon(
                                                      Icons.arrow_drop_down,
                                                      color: Colors.black45,
                                                    ),
                                                    iconSize: 24,
                                                  ),
                                                  dropdownStyleData:
                                                      DropdownStyleData(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                  ),
                                                  menuItemStyleData:
                                                      const MenuItemStyleData(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 16),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              child: Center(
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          getWidth() * 0.01,
                                                      vertical:
                                                          getHeight() * 0.001),
                                                  child:
                                                      DropdownButtonFormField2<
                                                          String>(
                                                    value: provider.value,
                                                    isExpanded: true,
                                                    decoration: InputDecoration(
                                                      fillColor: Colors.white,
                                                      filled: true,
                                                      // Add Horizontal padding using menuItemStyleData.padding so it matches
                                                      // the menu padding when button's width is not specified.
                                                      contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              vertical: 16),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      // Add more decoration..
                                                    ),
                                                    hint: const Text(
                                                      'Select Value',
                                                      style: TextStyle(
                                                          fontSize: 14),
                                                    ),
                                                    items: provider.pickedData
                                                        .map((item) =>
                                                            DropdownMenuItem<
                                                                String>(
                                                              value: item,
                                                              child: Text(
                                                                item,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                            ))
                                                        .toList(),
                                                    onChanged: (value) {
                                                      if (value != null) {
                                                        provider
                                                            .changeValue(value);
                                                      }
                                                    },
                                                    onSaved: (value) {},
                                                    buttonStyleData:
                                                        const ButtonStyleData(
                                                      padding: EdgeInsets.only(
                                                          right: 8),
                                                    ),
                                                    iconStyleData:
                                                        const IconStyleData(
                                                      icon: Icon(
                                                        Icons.arrow_drop_down,
                                                        color: Colors.black45,
                                                      ),
                                                      iconSize: 24,
                                                    ),
                                                    dropdownStyleData:
                                                        DropdownStyleData(
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                    ),
                                                    menuItemStyleData:
                                                        const MenuItemStyleData(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 16),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: getHeight() * 0.01,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    WidgetStatePropertyAll(
                                                        Colors.redAccent)),
                                            onPressed: () {
                                              provider.resetFilter();
                                            },
                                            child: Text(
                                              "Reset Filter",
                                              style: GoogleFonts.mulish(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600),
                                            )),
                                        SizedBox(
                                          width: getWidth() * 0.01,
                                        ),
                                        ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    WidgetStatePropertyAll(
                                                        Colors.blueAccent)),
                                            onPressed: () {
                                              provider.filterPegawai(
                                                  provider.filterValue);
                                            },
                                            child: Text(
                                              "Employee Filter",
                                              style: GoogleFonts.mulish(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600),
                                            )),
                                      ],
                                    ),
                                    SizedBox(
                                      height: getHeight() * 0.01,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      })
                    ],
                  )),
            ),
            SizedBox(
              height: getHeight() * 0.015,
            ),
            FutureBuilder(
                future: context.read<SqfliteProvider>().checkKoneksi(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    bool isConnect = false;
                    for (var i = 0; i < snapshot.data!.length; i++) {
                      if (snapshot.data![i] == ConnectivityResult.wifi ||
                          snapshot.data![i] == ConnectivityResult.mobile) {
                        isConnect = true;
                        break;
                      }
                    }
                    return FutureBuilder(
                      future: isConnect ? PegawaiData().getAllPegawai() : context.read<SqfliteProvider>().getAllPegawaiOff(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.data!.isEmpty) {
                          return Center(
                            child: Text("No Data Yet Sorry"),
                          );
                        } else {
                          context
                              .read<EmployeeFilterProvider>()
                              .initialPegawai(snapshot.data!);
                          return Consumer<EmployeeFilterProvider>(
                              builder: (context, provider, child) {
                            return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: provider.filteredPegawai.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: getWidth() * 0.01,
                                      vertical: getHeight() * 0.002),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return DetailPegawaiPage(
                                              idPegawai: provider
                                                  .filteredPegawai[index]
                                                  .idPegawai);
                                        },
                                      ));
                                    },
                                    child: Card(
                                      elevation: 4,
                                      color: Colors.white,
                                      child: Container(
                                        width: getWidth(),
                                        height: getHeight() * 0.08,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical:
                                                      getHeight() * 0.005),
                                              child: Container(
                                                width: getWidth() * 0.18,
                                                height: getHeight(),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.grey,
                                                  image: provider
                                                              .filteredPegawai[
                                                                  index]
                                                              .foto ==
                                                          ''
                                                      ? DecorationImage(
                                                          opacity: 0.6,
                                                          image: AssetImage(
                                                              'assets/default_profile.jpg'))
                                                      : DecorationImage(
                                                          image: NetworkImage(
                                                              provider
                                                                  .filteredPegawai[
                                                                      index]
                                                                  .foto)),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: getWidth() * 0.65,
                                              height: getHeight(),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    maxLines: 1,
                                                    overflow: TextOverflow.fade,
                                                    provider
                                                        .filteredPegawai[index]
                                                        .namaPegawai,
                                                    style: GoogleFonts.nunito(
                                                        fontSize: 18,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                  Text(
                                                    maxLines: 1,
                                                    overflow: TextOverflow.fade,
                                                    provider
                                                        .filteredPegawai[index]
                                                        .pangkat,
                                                    style: GoogleFonts.nunito(
                                                        fontSize: 18,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                                child: Container(
                                              child: Center(
                                                child: context
                                                            .read<
                                                                AuthProvider>()
                                                            .adminModel!
                                                            .role ==
                                                        'Admin'
                                                    ? IconButton(
                                                        onPressed: () {
                                                          showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return AlertDialog(
                                                                content: Text(
                                                                  "Apakah anda yakin ingin menghapus pegawai ini ?",
                                                                  style: GoogleFonts.nunito(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          17),
                                                                ),
                                                                actions: [
                                                                  TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        "Cancel",
                                                                        style: GoogleFonts.nunito(
                                                                            color:
                                                                                Colors.redAccent,
                                                                            fontWeight: FontWeight.w600,
                                                                            fontSize: 18),
                                                                      )),
                                                                  TextButton(
                                                                      onPressed:
                                                                          () async {
                                                                        provider
                                                                            .deleteSelectedPegawai(index)
                                                                            .then(
                                                                          (value) {
                                                                            Navigator.pop(context);
                                                                          },
                                                                        );
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        "Ok",
                                                                        style: GoogleFonts.nunito(
                                                                            color:
                                                                                Colors.blueAccent,
                                                                            fontWeight: FontWeight.w600,
                                                                            fontSize: 18),
                                                                      ))
                                                                ],
                                                                title: Text(
                                                                  "Hapus Pegawai",
                                                                  style: GoogleFonts.nunito(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          20),
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        },
                                                        icon: Icon(
                                                          size: 32,
                                                          Icons.delete,
                                                          color:
                                                              Colors.redAccent,
                                                        ))
                                                    : Container(),
                                              ),
                                            ))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          });
                        }
                      });
                  }
                  
                }),
          ],
        ));
  }
}
