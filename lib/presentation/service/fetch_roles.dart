import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/role.dart';

Future<List<Role>> fetchRoles() async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('roles').get();
  return querySnapshot.docs.map((doc) => Role.fromFirestore(doc)).toList();
}
