import 'package:flutter/material.dart';
import 'package:gestion_taches/model/Taches.dart';
import 'package:gestion_taches/repository/database.dart'; // Import du fichier user.repo.dart

class AddUserPage extends StatelessWidget {
  const AddUserPage({super.key}); // Correction de la syntaxe du constructeur

  @override
  Widget build(BuildContext context) {
    // Ajout de controllers pour récupérer les valeurs dans le formulaire name et age
    final ctrtitre = TextEditingController();
    final ctrdescription = TextEditingController();
    final ctrdateDebut = TextEditingController(); // Controller pour la date de début
    final ctrdateFin = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TextField(
                
                controller: ctrtitre,
                
                style: const TextStyle(fontSize: 22),
                decoration: const InputDecoration(
                  labelText: 'Titre',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(40),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                
                controller: ctrdescription,
                style: const TextStyle(fontSize: 22),
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(40),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: ctrdateDebut,
                style: const TextStyle(fontSize: 22),
                decoration: const InputDecoration(
                  labelText: 'Date de début',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: ctrdateFin,
                style: const TextStyle(fontSize: 22),
                decoration: const InputDecoration(
                  labelText: 'Date de fin',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  final String titre = ctrtitre.text.trim();
                  final String description = ctrdescription.text.trim();
                  final DateTime dateDebut = DateTime.parse(ctrdateDebut.text);
                  final DateTime dateFin = DateTime.parse(ctrdateFin.text);

                 if (titre.isNotEmpty && description.isNotEmpty ) {
                    final tache = Tache(
                      titre: titre,
                      description: description,
                      dateDebut: dateDebut,
                      dateFin: dateFin,
                      status: StatutTache.pasDebutee,
                      
                    );
                    addUser(tache);
                    
                               showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Succès'),
                          content: const Text('La tâche a été ajoutée avec succès.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );     } else {
                    
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Erreur'),
                          content:
                              const Text('Veuillez remplir tous les champs.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: const SizedBox(
                  width: double.infinity,
                  child: Icon(Icons.add, size: 32),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}