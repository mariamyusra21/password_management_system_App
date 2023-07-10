import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'storage_items.dart';

class StorageService {
  final _secureStorage = const FlutterSecureStorage();

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: false,
        
      );

  Future<void> writeSecureData(StorageItem newItem) async {
    debugPrint("Writing new data having key ${newItem.email_id}");
    await _secureStorage.write(
        key: newItem.email_id,
        value: newItem.password,
        aOptions: _getAndroidOptions());
  }

  Future<String?> readSecureData(String key) async {
    debugPrint("Reading data having key $key");
    var readData =
        await _secureStorage.read(key: key, aOptions: _getAndroidOptions());
    return readData;
  }

  Future<void> deleteSecureData(StorageItem item) async {
    debugPrint("Deleting data having key ${item.email_id}");
    await _secureStorage.delete(
        key: item.email_id, aOptions: _getAndroidOptions());
  }

  Future<List<StorageItem>> readAllSecureData() async {
    debugPrint("Reading all secured data");
    var allData = await _secureStorage.readAll(aOptions: _getAndroidOptions());
    List<StorageItem> list =
        allData.entries.map((e) => StorageItem(e.key, e.value)).toList();
    return list;
  }
}
