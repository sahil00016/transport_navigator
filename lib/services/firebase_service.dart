import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/route_model.dart';
import '../models/preference_model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveRoute(RouteModel route) async {
    await _firestore
        .collection('users')
        .doc('anonymous_user')
        .collection('routes')
        .doc(route.id)
        .set(route.toMap());
  }

  Stream<List<RouteModel>> getRouteHistory(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('routes')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => RouteModel.fromMap(doc.data())).toList());
  }

  Future<void> savePreference(String userId, double speedVsCost) async {
    await _firestore.collection('preferences').doc(userId).set({
      'userId': userId,
      'speedVsCost': speedVsCost,
    });
  }

  Future<PreferenceModel?> getPreference(String userId) async {
    final doc = await _firestore.collection('preferences').doc(userId).get();
    if (doc.exists) {
      return PreferenceModel.fromMap(doc.data()!);
    }
    return null;
  }
}