import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../model/role.dart';
import '../../../service/fetch_roles.dart';

class HimpunanStrukturPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("STRUKTUR Asrama Tanah Bumbu"),
        backgroundColor: Colors.green[400],
      ),
      body: FutureBuilder<List<Role>>(
        future: fetchRoles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No data available"));
          }

          // Map roles to their hierarchy
          List<Role> roles = snapshot.data!;
          return buildHierarchy(roles);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.swap_vert), label: "Mutasi"),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: "Info"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  Widget buildHierarchy(List<Role> roles) {
    // You’ll need to map your roles into a hierarchical structure here.
    // For simplicity, let’s assume the roles list is ordered by hierarchy.

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildRoleBox("Ketua Asrama", "Rafli"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildRoleBox("Bendahara", "Adi"),
              Column(
                children: [
                  buildRoleBox("Perlengkapan", "Ichsan"),
                  buildRoleBox("Kebersihan", "Malik"),
                  buildRoleBox("Keamanan", "Muhib"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildRoleBox(String title, String person) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(person),
        ],
      ),
    );
  }
}
