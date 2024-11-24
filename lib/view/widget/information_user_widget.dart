import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simpeg/models/admin_model.dart';
import 'package:simpeg/provider/detail_user_provider.dart';

class InformationUserWidget extends StatelessWidget {
  final String title;
  final bool isEditable;
  final int code;
  final String data;
  final AdminModel dataAdmin;
  const InformationUserWidget(
      {super.key,
      required this.data,
      required this.code,
      required this.title,
      required this.isEditable,
      required this.dataAdmin});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.01),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6))),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.08,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.04,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 1),
                      child: Text(
                        title,
                        style: GoogleFonts.nunito(
                            color: Colors.black,
                            fontSize: 19,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    isEditable
                        ? Consumer<DetailUserProvider>(
                            builder: (context, provider, child) {
                            return IconButton(
                                onPressed: () {
                                  provider.setField(data);
                                  if (code == 3) {
                                    provider.changeValue(data);
                                  }
                                  ScaffoldMessenger.of(context)
                                      .clearSnackBars();
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          duration: Duration(days: 365),
                                          content: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.13,
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.08,
                                                  child: Center(
                                                    child: Padding(
                                                      padding: EdgeInsets.symmetric(
                                                          horizontal:
                                                              MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.01,
                                                          vertical: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.005),
                                                      child: code != 3
                                                          ? TextFormField(
                                                              controller: provider
                                                                  .etEditField,
                                                              decoration: InputDecoration(
                                                                  hintText:
                                                                      "Edit ${title}",
                                                                  border: OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.all(Radius.circular(
                                                                              12))),
                                                                  filled: true,
                                                                  fillColor:
                                                                      Colors
                                                                          .white),
                                                            )
                                                          : DropdownButtonFormField2<
                                                              String>(
                                                              value: provider
                                                                  .value,
                                                              isExpanded: true,
                                                              decoration:
                                                                  InputDecoration(
                                                                fillColor:
                                                                    Colors
                                                                        .white,
                                                                filled: true,
                                                                // Add Horizontal padding using menuItemStyleData.padding so it matches
                                                                // the menu padding when button's width is not specified.
                                                                contentPadding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                        vertical:
                                                                            16),
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15),
                                                                ),
                                                                // Add more decoration..
                                                              ),
                                                              hint: const Text(
                                                                'Select Filter',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14),
                                                              ),
                                                              items: provider
                                                                  .pickedData
                                                                  .map((item) =>
                                                                      DropdownMenuItem<
                                                                          String>(
                                                                        value:
                                                                            item,
                                                                        child:
                                                                            Text(
                                                                          item,
                                                                          style:
                                                                              const TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                          ),
                                                                        ),
                                                                      ))
                                                                  .toList(),
                                                              validator:
                                                                  (value) {
                                                                if (value ==
                                                                    null) {
                                                                  return 'Please select filter.';
                                                                }
                                                                return null;
                                                              },
                                                              onChanged:
                                                                  (value) {
                                                                if (value !=
                                                                    null) {
                                                                  provider
                                                                      .changeValue(
                                                                          value);
                                                                }
                                                              },
                                                              buttonStyleData:
                                                                  const ButtonStyleData(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        right:
                                                                            8),
                                                              ),
                                                              iconStyleData:
                                                                  const IconStyleData(
                                                                icon: Icon(
                                                                  Icons
                                                                      .arrow_drop_down,
                                                                  color: Colors
                                                                      .black45,
                                                                ),
                                                                iconSize: 24,
                                                              ),
                                                              dropdownStyleData:
                                                                  DropdownStyleData(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15),
                                                                ),
                                                              ),
                                                              menuItemStyleData:
                                                                  const MenuItemStyleData(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            16),
                                                              ),
                                                            ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                    child: Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      TextButton(
                                                          onPressed: () {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .clearSnackBars();
                                                          },
                                                          child: Text(
                                                            "Cancel",
                                                            style: GoogleFonts
                                                                .nunito(
                                                                    color: Colors
                                                                        .red,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        20),
                                                          )),
                                                      TextButton(
                                                          onPressed: () async {
                                                            if (await provider
                                                                .updateField(
                                                                    code,
                                                                    dataAdmin
                                                                        .idAdmin,
                                                                    dataAdmin
                                                                        .email,
                                                                    dataAdmin
                                                                        .username,
                                                                    dataAdmin
                                                                        .role)) {
                                                              Fluttertoast
                                                                  .showToast(
                                                                      msg:
                                                                          "Success");
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .clearSnackBars();
                                                            } else {
                                                              Fluttertoast
                                                                  .showToast(
                                                                      msg:
                                                                          "Failed");
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .clearSnackBars();
                                                            }
                                                          },
                                                          child: Text(
                                                            "Ok",
                                                            style: GoogleFonts.nunito(
                                                                color: Colors
                                                                    .blueAccent,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 20),
                                                          ))
                                                    ],
                                                  ),
                                                ))
                                              ],
                                            ),
                                          )));
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                ));
                          })
                        : Container()
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 1),
                    child: Text(
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      data,
                      style: GoogleFonts.nunito(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
