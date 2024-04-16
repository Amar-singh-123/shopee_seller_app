import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/responses/db_response.dart';

class AppFireStoreDatabase {
  AppFireStoreDatabase({required this.collection});

  String collection;
  final _database = FirebaseFirestore.instance;


  Future<DbResponse> insert({required Map<String, dynamic> data}) async {
    try {
      await _database.collection(collection).add(data).then((value) {
        _database.collection(collection).doc(value.id).set(data);
      });
      return DbResponse(statusCode: 200, success: true, error: null,);
    } catch (e) {
      return DbResponse(statusCode: 500, success: false, error: e.toString());
    }
  }
  Future<DbResponse> set({required Map<String, dynamic> data,required String doc}) async {
    try {
      await _database.collection(collection).doc(doc).set(data);
      return DbResponse(statusCode: 200, success: true, error: null,);
    } catch (e) {
      return DbResponse(statusCode: 500, success: false, error: e.toString());
    }
  }

  Future<DbResponse> update(
      {required Map<String, dynamic> data, required String doc}) async {
    try {
      await _database.collection(collection).doc(doc).update(data);
      return DbResponse(success: true, statusCode: 200, error: null);
    } catch (e) {
      return DbResponse(success: false, error: e.toString(), statusCode: 500);
    }
  }

  Future<DbResponse> delete({required String doc}) async {
    try {
      await _database.collection(collection).doc(doc).delete();
      return DbResponse(success: true, statusCode: 200, error: null);
    } catch (e) {
      return DbResponse(success: false, error: e.toString(), statusCode: 500);
    }
  }

  DbResponse getAllAsStream() {
    try {
      var resp = _database.collection(collection).snapshots();
      return DbResponse(
          success: true, statusCode: 200, streamAllData: resp, error: null);
    } catch (e) {
      return DbResponse(
        statusCode: 500,
        error: e.toString(),
        success: false,
      );
    }
  }

  Future<DbResponse> getAllAsFuture() async {
    try {
      var resp = await _database.collection(collection).get();
      return DbResponse(
          success: true, statusCode: 200, futureAllData: resp, error: null);
    } catch (e) {
      return DbResponse(
        statusCode: 500,
        error: e.toString(),
        success: false,
      );
    }
  }

  DbResponse getOneAsStream({required String doc}) {
    try {
      var resp = _database.collection(collection).doc(doc).snapshots();
      return DbResponse(
          success: true, statusCode: 200, streamOneData: resp, error: null);
    } catch (e) {
      return DbResponse(
        statusCode: 500,
        error: e.toString(),
        success: false,
      );
    }
  }

  Future<DbResponse> getOneAsFuture({required String doc}) async {
    try {
      var resp = await _database.collection(collection).doc(doc).get();
      return DbResponse(
          success: true, statusCode: 200, futureOneData: resp, error: null);
    } catch (e) {
      return DbResponse(
        statusCode: 500,
        error: e.toString(),
        success: false,
      );
    }
  }
}
