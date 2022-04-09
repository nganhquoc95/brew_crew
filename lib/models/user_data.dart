import 'package:brew_crew/models/brew.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserData extends Brew {
  UserData({id, name, sugars, strength})
      : super(id: id, name: name, sugars: sugars, strength: strength);

  factory UserData.fromSnapshot(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return UserData(
      id: doc.id,
      name: data['name'],
      sugars: data['sugars'],
      strength: data['strength'],
    );
  }
}
