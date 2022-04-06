import 'package:cloud_firestore/cloud_firestore.dart';

class Brew {
  final String id;
  final String name;
  final String sugars;
  final int strength;

  Brew({
    required this.id,
    required this.name,
    required this.sugars,
    required this.strength,
  });

  factory Brew.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Brew(
      id: doc.id,
      name: data['name'],
      sugars: data['sugars'],
      strength: data['strength'],
    );
  }

  toJson() {
    return {
      'id': id,
      'name': name,
      'sugars': sugars,
      'strength': strength,
    };
  }
}
