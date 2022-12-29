import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:onlyrecipeapp/services/services.dart';
import 'dart:developer';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Listens to current user's report document in Firestore
  Stream<Favorites> streamFavorites() {
    return AuthService().userStream.switchMap((user) {
      if (user != null) {
        var ref = _db.collection('favorites').doc(user.uid);
        return ref.snapshots().map((doc) => Favorites.fromJson(doc.data()!));
      } else {
        return Stream.fromIterable([Favorites()]);
      }
    });
  }
}
