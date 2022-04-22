import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final storage = FlutterSecureStorage();
  Future writeSecureData(String key, String value) async {
    var writeData = await storage.write(key: key, value: value);
    return writeData;
  }
  Future readSecureData(String key) async {
    var readData = await storage.read(key: key);
    return readData;
  }
  Future readAllSecureData() async {
    var readAllData = await storage.readAll();
    return readAllData;
  }
  Future deleteSecureData(String key) async {
    var deleteData = await storage.delete(key: key);
    return deleteData;
  }
  Future deleteAllSecureData() async {
    var deleteAllData = await storage.deleteAll();
    return deleteAllData;
  }
}