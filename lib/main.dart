import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simpeg/provider/add_user_provider.dart';
import 'package:simpeg/provider/auth_provider.dart';
import 'package:simpeg/provider/bottom_nav_provider.dart';
import 'package:simpeg/provider/detail_pegawai_provider.dart';
import 'package:simpeg/provider/edit_user_provider.dart';
import 'package:simpeg/provider/employee_filter_provider.dart';
import 'package:simpeg/provider/gemini_chat_provider.dart';
import 'package:simpeg/provider/search_pegawai_provider.dart';
import 'package:simpeg/provider/steganograph_decrypt_provider.dart';
import 'package:simpeg/provider/steganograph_encrypt_provider.dart';
import 'package:simpeg/provider/tambah_karyawan_provider.dart';
import 'package:simpeg/provider/user_filter_provider.dart';
import 'package:simpeg/provider/validate_pegawai_provier.dart';
import 'package:simpeg/view/pages/main_page.dart';
import 'package:simpeg/view/pages/onboarding_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BottomNavProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => EmployeeFilterProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserFilterProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TambahKaryawanProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchPegawaiProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DetailPegawaiProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddUserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ValidatePegawaiProvier(),
        ),
        ChangeNotifierProvider(
          create: (context) => GeminiChatProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => EditUserProvider(),
        ),
        ChangeNotifierProvider(create: (context) => SteganographEncryptProvider(),),
        ChangeNotifierProvider(create: (context) => SteganographDecryptProvider(),)
      ],
      child: MyApp(
        token: prefs.getString('token'),
      )));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatelessWidget {
  final String? token;
  const MyApp({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Consumer<AuthProvider>(builder: (context, provider, child) {
          if (token == null || token == '' || JwtDecoder.isExpired(token!)) {
            return OnBoardingPage();
          } else {
            int idAdmin = JwtDecoder.decode(token!)['id_user'];
            print(idAdmin);
            print(token);
            return FutureBuilder(
              future: provider.getSingleUser(idAdmin),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  if (provider.adminModel == null) {
                    return OnBoardingPage();
                  } else {
                    return MainPage();
                  }
                }
              },
            );
          }
        }));
  }
}
