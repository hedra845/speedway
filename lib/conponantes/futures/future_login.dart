import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sender/config/Strings.dart';
import 'package:uid/uid.dart';

class LoginResult {
  final bool success;
  final String? errorMessage;

  LoginResult({required this.success, this.errorMessage});
}

Future<LoginResult> userLogin(String username, String password) async {
  try {
    const storage = FlutterSecureStorage();
    String? uid = await storage.read(key: 'uid');
    if (uid == null || uid.isEmpty) {
      uid = UId.getId();
      await storage.write(key: 'uid', value: uid);
    }

    var data = FormData.fromMap({
      'uid': uid,
      'username': username.trim().toLowerCase(),
      'password': password,
    });

    var dio = Dio();
    var response = await dio.post(
      Apis.LOGIN_URL,
      data: data,
      options: Options(
        validateStatus: (status) => status != null && status < 500,
      ),
    );

    dynamic responseData = response.data;
    if (responseData is String) {
      try {
        responseData = json.decode(responseData);
      } catch (_) {}
    }

    if (responseData is Map) {
      final token = responseData['token'];
      if (token != null &&
          token.toString() != "null" &&
          token.toString().isNotEmpty) {
        await storage.write(key: 'token', value: token.toString());
        if (responseData['company_id'] != null) {
          await storage.write(
              key: 'company_id', value: responseData['company_id'].toString());
        }
        await storage.write(key: 'username', value: username.trim().toLowerCase());
        if (responseData['companyname'] != null) {
          await storage.write(
              key: 'name', value: responseData['companyname'].toString());
        }
        return LoginResult(success: true);
      } else {
        String errorMsg = responseData['error']?.toString() ??
            responseData['message']?.toString() ??
            'اسم المستخدم أو كلمة المرور غير صحيحة';
        return LoginResult(success: false, errorMessage: errorMsg);
      }
    }

    return LoginResult(
        success: false, errorMessage: 'تعذر تسجيل الدخول، يرجى المحاولة لاحقاً');
  } on DioException catch (e) {
    String message = 'فشل الاتصال بالخادم';
    if (e.response?.data != null && e.response?.data is Map) {
      message = e.response?.data['error']?.toString() ??
          e.response?.data['message']?.toString() ??
          message;
    }
    return LoginResult(success: false, errorMessage: message);
  } catch (e) {
    return LoginResult(
        success: false, errorMessage: 'حدث خطأ أثناء تسجيل الدخول: $e');
  }
}
