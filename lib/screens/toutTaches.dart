import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gestion_taches/model/Taches.dart';
import 'package:gestion_taches/screens/widget/listTaches.dart';

class AllUser extends StatefulWidget {
  const AllUser({super.key});

  @override
  State<AllUser> createState() => _AllUserState();
}

class _AllUserState extends State<AllUser> {
  @override
  Widget build(BuildContext context) {
    List<Tache> allusers = [];
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('taches')
            .orderBy('titre')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error'),
            );
          }
          if (snapshot.hasData) {
            allusers = snapshot.data!.docs
                .map((doc) => Tache.fromJson(doc.data() as Map<String, dynamic>))
                .toList();
            return ListUsers(users: allusers);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
