import 'package:cloud_firestore/cloud_firestore.dart';

class DbResponse {
  bool success;
  dynamic error;
  int statusCode;
  Stream<QuerySnapshot<Map<String, dynamic>>>? streamAllData;
  Stream<DocumentSnapshot<Map<String, dynamic>>>? streamOneData;
  QuerySnapshot<Map<String, dynamic>>? futureAllData;
  DocumentSnapshot<Map<String, dynamic>>? futureOneData;

  DbResponse(
      {this.success = true,
      this.error,
      this.statusCode = 200,
      this.streamAllData,
      this.streamOneData,
      this.futureAllData,
      this.futureOneData});
}
