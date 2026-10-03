import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<void> clearToken() async {
  const FlutterSecureStorage secureStorage = FlutterSecureStorage();
  await secureStorage.delete(key: 'token');
  await secureStorage.delete(key: 'company_id');
  await secureStorage.delete(key: 'username');
  await secureStorage.delete(key: 'name');
}