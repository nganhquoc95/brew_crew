import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/models/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  // Collection references
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  DatabaseService({required this.uid});

  DatabaseService.withoutUID() : uid = "";

  Future updateUserData(String name, String sugars, int strength) async {
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map(Brew.fromSnapshot).toList();
  }

  // get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots().map(UserData.fromSnapshot);
  }
}
