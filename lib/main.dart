import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:simpeg/provider/add_user_provider.dart';
import 'package:simpeg/provider/auth_provider.dart';
import 'package:simpeg/provider/bottom_nav_provider.dart';
import 'package:simpeg/provider/detail_pegawai_provider.dart';
import 'package:simpeg/provider/edit_user_provider.dart';
import 'package:simpeg/provider/employee_filter_provider.dart';
import 'package:simpeg/provider/gemini_chat_provider.dart';
import 'package:simpeg/provider/search_pegawai_provider.dart';
import 'package:simpeg/provider/tambah_karyawan_provider.dart';
import 'package:simpeg/provider/user_filter_provider.dart';
import 'package:simpeg/provider/validate_pegawai_provier.dart';
import 'package:simpeg/view/pages/onboarding_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthProvider(),),
      ChangeNotifierProvider(create: (context) => BottomNavProvider(),),
      ChangeNotifierProvider(create: (context) => EmployeeFilterProvider(),),
      ChangeNotifierProvider(create: (context) => UserFilterProvider(),),
      ChangeNotifierProvider(create: (context) => TambahKaryawanProvider(),),
      ChangeNotifierProvider(create: (context) => SearchPegawaiProvider(),),
      ChangeNotifierProvider(create: (context) => DetailPegawaiProvider(),),
      ChangeNotifierProvider(create: (context) => AddUserProvider(),),
      ChangeNotifierProvider(create: (context) => ValidatePegawaiProvier(),),
      ChangeNotifierProvider(create: (context) => GeminiChatProvider(),),
      ChangeNotifierProvider(create: (context) => EditUserProvider(),)
    ],
    child: MyApp()));
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  OnBoardingPage());
  }
}
