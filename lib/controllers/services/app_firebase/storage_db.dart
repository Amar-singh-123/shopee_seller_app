import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../models/responses/storage_response.dart';

class AppFirebaseStorage {
  AppFirebaseStorage({required this.storageCollection});

  String storageCollection;
  final _database = FirebaseStorage.instance;

  Future<StorageResponse> insertFile(
      {required File file, required String filename}) async {
    try {
      var resp = await _database
          .ref()
          .child(storageCollection)
          .child(filename)
          .putFile(file, SettableMetadata(contentType: "image/jpeg"));
      var url = await resp.ref.getDownloadURL();
      return StorageResponse(
          statusCode: 200, success: true, error: null, url: url);
    } catch (e) {
      return StorageResponse(
          statusCode: 500, success: false, error: e.toString(), url: null);
    }
  }

  Future<StorageResponse> updateFile(
      {required File file, required String filename}) async {
    return await insertFile(file: file, filename: filename);
  }

  Future<StorageResponse> delete({required String fileName}) async {
    try {
      await _database.ref().child(storageCollection).child(fileName).delete();
      return StorageResponse(success: true, error: null, statusCode: 200);
    } catch (e) {
      return StorageResponse(
          statusCode: 500, success: false, error: e.toString());
    }
  }

  getFileUrl({required String fileName}) async {
    try {
      var resp = await _database
          .ref()
          .child(storageCollection)
          .child(fileName)
          .getDownloadURL();
      return StorageResponse(
          success: true, error: null, statusCode: 200, url: resp);
    } catch (e) {
      return StorageResponse(
          statusCode: 500, success: false, error: e.toString());
    }
  }
}
