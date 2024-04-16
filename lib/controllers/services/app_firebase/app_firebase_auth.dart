import 'package:firebase_auth/firebase_auth.dart';

import 'firestore_db.dart';

class AppAuth {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static String? get userId => auth.currentUser?.uid;
static User? get currentUser =>auth.currentUser;
  static bool get isVerified => auth.currentUser?.uid != null;
static get signOut => auth.signOut();
  static Future<bool> get detailsStatus async {
    var res = await AppFireStoreDatabase(collection: "seller_profile")
        .getOneAsFuture(doc: userId.toString());
    return res.futureOneData?.exists ?? false;
  }

}
