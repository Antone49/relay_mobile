import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  final storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      )
  );

  Future<bool> hasKey(String key) async {
    String? value = await storage.read(key: key);
    return value != null;
  }

  Future<String?> read(String key) async {
    return await storage.read(key: key);
  }

  Future<Map<String, String>> readAll() async {
    return await storage.readAll();
  }

  void write(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  void delete(String key) async {
    await storage.delete(key: key);
  }

  void deleteAll() async {
    await storage.deleteAll();
  }
}