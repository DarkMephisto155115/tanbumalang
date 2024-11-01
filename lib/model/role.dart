import 'package:cloud_firestore/cloud_firestore.dart';

class Role {
  final String name;
  final String person;
  final String position;
  final String parentId;

  Role({required this.name, required this.person, required this.position, required this.parentId});

  factory Role.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Role(
      name: data['name'] ?? '',
      person: data['person'] ?? '',
      position: data['position'] ?? '',
      parentId: data['parentId'] ?? '',
    );
  }
}
