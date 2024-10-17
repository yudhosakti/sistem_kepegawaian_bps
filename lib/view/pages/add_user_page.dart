import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simpeg/provider/add_user_provider.dart';
import 'package:simpeg/view/widget/single_form_widget.dart';

class AddUserPage extends StatelessWidget {
  const AddUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add User"),
      ),
      body: Consumer<AddUserProvider>(builder: (context, provider, child) {
        return ListView(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.22,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                      image: provider.fileImage == null
                          ? DecorationImage(
                              opacity: 0.6,
                              image: AssetImage('assets/default_profile.jpg'),
                            )
                          : DecorationImage(
                              image: FileImage(provider.fileImage!),
                              fit: BoxFit.fill),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          right: 0,
                          bottom: MediaQuery.of(context).size.height * 0.01,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.1,
                            height: MediaQuery.of(context).size.height * 0.05,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.redAccent),
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    shape:
                                        WidgetStatePropertyAll(CircleBorder()),
                                    padding: WidgetStatePropertyAll(
                                        EdgeInsets.zero)),
                                onPressed: () async {
                                  if (await provider.takePickture()) {
                                    print("Success");
                                  } else {
                                    print("Canceled");
                                  }
                                },
                                child: Icon(
                                  Icons.camera,
                                  color: Colors.black,
                                )),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SingleFormWidget(
              isEditable: true,
              editingController: provider.username,
              hintText: "Masukkan Username",
              title: "Username",
            ),
            SingleFormWidget(
              isEditable: true,
              editingController: provider.email,
              hintText: "Masukkan Email",
              title: "Email",
            ),
            Padding(
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
                          "Password",
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
                        child: TextFormField(
                          obscureText: true,
                          style: GoogleFonts.nunito(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 17),
                          enabled: true,
                          controller: provider.password,
                          decoration: InputDecoration(
                              hintText: "Masukkan Password",
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)))),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.01),
              child: Text(
                "Role",
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.48,
              height: MediaQuery.of(context).size.height * 0.08,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.3,
                    bottom: MediaQuery.of(context).size.width * 0.001,
                    top: MediaQuery.of(context).size.height * 0.001,
                    left: MediaQuery.of(context).size.width * 0.01,
                  ),
                  child: DropdownButtonFormField2<String>(
                    value: provider.value,
                    isExpanded: true,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      // Add Horizontal padding using menuItemStyleData.padding so it matches
                      // the menu padding when button's width is not specified.
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      // Add more decoration..
                    ),
                    hint: const Text(
                      'Select Filter',
                      style: TextStyle(fontSize: 14),
                    ),
                    items: provider.pickedData
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
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
                        provider.changeValue(value);
                      }
                    },
                    onSaved: (value) {},
                    buttonStyleData: const ButtonStyleData(
                      padding: EdgeInsets.only(right: 8),
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      ),
                      iconSize: 24,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.06,
        margin: EdgeInsets.only(bottom: 2),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.1,
              vertical: MediaQuery.of(context).size.height * 0.005),
          child: Consumer<AddUserProvider>(builder: (context, provider, child) {
            return ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.blueAccent),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))))),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text(
                          "Apakah Anda Yakin Ingin Menambahkan Pegawai Ini",
                          style: GoogleFonts.nunito(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                        title: Text(
                          "Perhatian",
                          style: GoogleFonts.nunito(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Cancel",
                                style: GoogleFonts.nunito(
                                    fontSize: 18,
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.w600),
                              )),
                          TextButton(
                              onPressed: () async {
                                if (provider.isLoading) {
                                  print("Loading");
                                } else {
                                  if (await provider.addUser()) {
                                    print("Success");
                                    Navigator.pop(context);
                                  } else {
                                    print("Failed");
                                    Navigator.pop(context);
                                  }
                                }
                              },
                              child: Text(
                                "Ok",
                                style: GoogleFonts.nunito(
                                    fontSize: 18,
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.w600),
                              ))
                        ],
                      );
                    },
                  );
                },
                child: Text(
                  "Tambah User",
                  style: GoogleFonts.nunito(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ));
          }),
        ),
      ),
    );
  }
}
