import 'dart:convert';
import 'package:emailjs/emailjs.dart' as emailjs;
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:simpeg/data/host_data.dart';
import 'package:simpeg/models/admin_model.dart';
import 'package:simpeg/models/log_model.dart';

class AdminData {
  Future<AdminModel?> loginUser(String email, String password, int code) async {
    AdminModel? data;

    try {
      if (code == 1) {
        var response = await http.post(Uri.parse("${hostData}/user/login"),
            headers: {
              "Accept": "application/json",
              "content-type": "application/json",
            },
            body: jsonEncode({"email": email, "password": password}));
        if (response.statusCode == 200) {
          var jsonData = jsonDecode(response.body);
          dynamic jsonMap = (jsonData as Map<String, dynamic>)['data'];
          data = AdminModel.getDataFromJSON(jsonMap);
          data.token = jsonData['token'];
          print("Token : " + data.token);
          return data;
        } else {
          return data;
        }
      } else {
        var response =
            await http.post(Uri.parse("${hostData}/user/login/image"),
                headers: {
                  "Accept": "application/json",
                  "content-type": "application/json",
                },
                body: jsonEncode({"email": email}));
        if (response.statusCode == 200) {
          var jsonData = jsonDecode(response.body);
          dynamic jsonMap = (jsonData as Map<String, dynamic>)['data'];
          data = AdminModel.getDataFromJSON(jsonMap);
          data.token = jsonData['token'];
          print("Token : " + data.token);
          return data;
        } else {
          return data;
        }
      }
    } catch (e) {
      return data;
    }
  }

  Future<bool> sendEmail(
      String name, String email, String subject, String message) async {
    String serviceId = "service_no5c5gl";
    String templateId = "template_j3jjaia";

    try {
      await emailjs.send(
          serviceId,
          templateId,
          {
            'user_name': name,
            'To_Email': email,
            'user_subject': subject,
            'user_message': message
          },
          const emailjs.Options(
              publicKey: '0UUbSnUJ6-aR6bG4J',
              privateKey: "GDDwYSLvF-h8_tSRwuCL1"));
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> registerUser(
      String email, String username, String password) async {
    try {
      var response = await http.post(Uri.parse("${hostData}/user/register"),
          headers: {
            "Accept": "application/json",
            "content-type": "application/json",
          },
          body: jsonEncode(
              {"email": email, "username": username, "password": password}));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<List<AdminModel>> getRecentUser() async {
    List<AdminModel> adminList = [];

    try {
      var response = await http.get(Uri.parse("${hostData}/user/recent"));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        List<dynamic> jsonMapping = (jsonData as Map<String, dynamic>)['data'];

        for (var element in jsonMapping) {
          adminList.add(AdminModel.getDataFromJSON(element));
        }
        return adminList;
      } else {
        print(response.body);
        return adminList;
      }
    } catch (e) {
      print(e);
      return adminList;
    }
  }

  Future<List<AdminModel>> getAllUser() async {
    List<AdminModel> adminList = [];

    try {
      var response = await http.get(Uri.parse("${hostData}/user"));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        List<dynamic> jsonMapping = (jsonData as Map<String, dynamic>)['data'];

        for (var element in jsonMapping) {
          adminList.add(AdminModel.getDataFromJSON(element));
        }
        return adminList;
      } else {
        print(response.body);
        return adminList;
      }
    } catch (e) {
      print(e);
      return adminList;
    }
  }

  Future<bool> updateStatusAdmin(int idUser) async {
    try {
      var response = await http.put(
        Uri.parse(
            "${hostData}/user/status?id_user=${idUser}&status=Tidak Aktif"),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
        },
      );
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

  Future<bool> addUser(AdminModel admin) async {
    try {
      Dio dio = Dio();
      if (admin.avatar == '') {
        FormData formData = FormData.fromMap({
          "username": admin.username,
          "email": admin.email,
          "password": admin.password,
          "role": admin.role,
        });

        var response = await dio.post("${hostData}/user/insert",
            data: formData,
            options: Options(contentType: 'multipart/form-data'));
        if (response.statusCode == 200) {
          return true;
        } else {
          return false;
        }
      } else {
        FormData formData = FormData.fromMap({
          "image": await MultipartFile.fromFile(admin.avatar,
              filename: admin.avatar.split('/').last),
          "username": admin.username,
          "email": admin.email,
          "password": admin.password,
          "role": admin.role,
        });

        var response = await dio.post("${hostData}/user/insert",
            data: formData,
            options: Options(contentType: 'multipart/form-data'));
        if (response.statusCode == 200) {
          return true;
        } else {
          return false;
        }
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<AdminModel?> updateUser(
      int idUSer, String username, String email, String role) async {
    AdminModel? adminData;

    try {
      var response = await http.put(Uri.parse("${hostData}/user/update"),
          headers: {
            "Accept": "application/json",
            "content-type": "application/json",
          },
          body: jsonEncode({
            "id_user": idUSer,
            "username": username,
            "email": email,
            "role": role
          }));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        dynamic dataUser = (jsonData as Map<String, dynamic>)['data'];
        adminData = AdminModel.getDataFromJSON(dataUser);
        return adminData;
      } else {
        return adminData;
      }
    } catch (e) {
      print(e);
      return adminData;
    }
  }

  Future<AdminModel?> updateAdminProfile(
      int idAdmin, String image, String username, String email) async {
    try {
      Dio dio = Dio();
      if (image == '') {
        FormData formData = FormData.fromMap({
          "id_user": idAdmin,
          "username": username,
          "email": email,
        });

        var response = await dio.put("${hostData}/user",
            data: formData,
            options: Options(contentType: 'multipart/form-data'));
        print(response.data);
        if (response.statusCode == 200) {
          var jsonData = response.data;
          dynamic jsonMap = (jsonData as Map<String, dynamic>)['data'];
          AdminModel adminModel = AdminModel.getDataFromJSON(jsonMap);
          return adminModel;
        } else {
          return null;
        }
      } else {
        FormData formData = FormData.fromMap({
          "image": await MultipartFile.fromFile(image,
              filename: image.split('/').last),
          "username": username,
          "id_user": idAdmin,
          "email": email,
        });

        var response = await dio.put("${hostData}/user",
            data: formData,
            options: Options(contentType: 'multipart/form-data'));
        print(response.data);
        if (response.statusCode == 200) {
          var jsonData = response.data;
          dynamic jsonMap = (jsonData as Map<String, dynamic>)['data'];
          AdminModel adminModel = AdminModel.getDataFromJSON(jsonMap);
          return adminModel;
        } else {
          return null;
        }
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<AdminModel?> getSingleAdmin(int idAdmin) async {
    AdminModel? model;
    try {
      var response = await http
          .get(Uri.parse("${hostData}/user/single?id_user=${idAdmin}"));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);

        dynamic jsonMap = (jsonData as Map<String, dynamic>)['data'];
        model = AdminModel.getDataFromJSON(jsonMap);
        return model;
      } else {
        print(response.body);
        return model;
      }
    } catch (e) {
      print(e);
      return model;
    }
  }

  Future<List<LogModel>> getLogData(int idUser) async {
    List<LogModel> logDatas = [];

    try {
      var response =
          await http.get(Uri.parse("${hostData}/user/log?id_user=${idUser}"));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        List<dynamic> jsonMap = (jsonData as Map<String, dynamic>)['data'];
        for (var element in jsonMap) {
          logDatas.add(LogModel.getDataFromJSON(element));
        }
        return logDatas;
      } else {
        print(response.body);
        return logDatas;
      }
    } catch (e) {
      print(e);
      return logDatas;
    }
  }
}
