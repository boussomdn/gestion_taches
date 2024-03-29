import 'package:flutter/material.dart';
import 'package:gestion_taches/screens/ajoutTaches.dart';
import 'package:gestion_taches/screens/toutTaches.dart';

class ControlePage extends StatelessWidget {
  const ControlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 250, 224, 246),
          title: const Text('Gestion des tache', textAlign: TextAlign.center),
          centerTitle: true,
        ),
        body: const TabBarView(
          children: [
            AddUserPage(),
            AllUser(),
            Center(
              child: Text('Page3'),
            )
          ],
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 250, 224, 246),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: const TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  Icons.add_task,
                  size: 30,
                ),
                text: 'Ajout',
              ),
              Tab(
                icon: Icon(
                  Icons.task,
                  size: 30,
                ),
                text: 'Tâches',
              ),
              Tab(
                icon: Icon(
                  Icons.search,
                  size: 28,
                ),
                text: 'Recherche',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
