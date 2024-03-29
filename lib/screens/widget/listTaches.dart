import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gestion_taches/model/Taches.dart';
import 'package:gestion_taches/repository/database.dart';

class ListUsers extends StatefulWidget {
  final List<Tache> users;
  const ListUsers({super.key, required this.users});
  
  @override
  State<ListUsers> createState() => _ListUsersState();
}

class _ListUsersState extends State<ListUsers> {
  final TextEditingController ctrupdatetitre = TextEditingController();
  final TextEditingController ctrupdatedescription = TextEditingController();
  final TextEditingController ctrupdateDateDebut = TextEditingController(); // Controller for updated date debut
  final TextEditingController ctrupdateDateFin = TextEditingController(); // Controller for updated date fin

  

  @override
  Widget build(BuildContext context) {
    final allusers = widget.users;

    // Fonction pour obtenir la couleur de l'avatar en fonction du statut
Color getAvatarColor(StatutTache statut) {
  switch (statut) {
    case StatutTache.enCours:
      return Colors.yellow;
    case StatutTache.pasDebutee:
      return Colors.red;
    case StatutTache.terminee:
      return Colors.green;
    default:
      return Colors.grey; // Par défaut, la couleur est grise
  }
}



    return ListView.builder(
      itemCount: allusers.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: getAvatarColor(allusers[index].status),
              child: Text(
                allusers[index].titre.substring(0, 2).toUpperCase(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            title: Text(
              allusers[index].titre,
              style: const TextStyle(fontSize: 22),
            ),
            subtitle: Text(
              allusers[index].description,
              style: const TextStyle(fontSize: 22),
              ),
              
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [

                
                // Bouton radio pour "En cours"
              Radio(
                value: StatutTache.enCours,
                groupValue: allusers[index].status,
                onChanged: (value) {
                  setState(() {
                    allusers[index].status = value as StatutTache;
                  });
                },
              ),
              const Text('En cours'),

              // Bouton radio pour "Non commencé"
              Radio(
                value: StatutTache.pasDebutee,
                groupValue: allusers[index].status,
                onChanged: (value) {
                  setState(() {
                    allusers[index].status = value as StatutTache;
                  });
                },
              ),
              const Text('Non commencé'),

              // Bouton radio pour "Terminé"
              Radio(
                value: StatutTache.terminee,
                groupValue: allusers[index].status,
                onChanged: (value) {
                  setState(() {
                    allusers[index].status = value as StatutTache;
                  });
                },
              ),
              const Text('Terminé'),
                        
                TextButton(
                  onPressed: () {
                    // Mettre à jour les champs de texte avec les informations actuelles de l'utilisateur sélectionné
                    ctrupdatetitre.text = allusers[index].titre;
                    ctrupdatedescription.text = allusers[index].description;
                    ctrupdateDateDebut.text = allusers[index].dateDebut.toIso8601String(); // Format date for display
                    ctrupdateDateFin.text = allusers[index].dateFin.toIso8601String(); // Format date for display

                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Update: ${allusers[index].titre}'),
                        content: SingleChildScrollView(
                          child: SizedBox(
                            height: 300,
                          
                            child: Column(
                              children: [
                                TextField(
                                  style: const TextStyle(
                                    fontSize: 22,
                                  ),
                                  decoration: const InputDecoration(
                                    labelText: 'Titre',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(40),
                                      ),
                                    ),
                                  ),
                                  controller: ctrupdatetitre,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextField(
                                  style: const TextStyle(
                                    fontSize: 22,
                                  ),
                                  decoration: const InputDecoration(
                                    labelText: 'Description',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(40),
                                      ),
                                    ),
                                  ),
                                  controller: ctrupdatedescription,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                // Add Date fields
                                
                               
                                ElevatedButton(
                                  onPressed: () {
                                    // Ajoutez ici la logique de mise à jour des informations de l'utilisateur
                                    final user = Tache(
                                      id: allusers[index].id,
                                      titre: ctrupdatetitre.text,
                                      description: ctrupdatedescription.text,
                                      dateDebut: DateTime.parse(ctrupdateDateDebut.text), // Parse updated date debut
                                      dateFin: DateTime.parse(ctrupdateDateFin.text),
                                    );

                                    updateUser(user);
                                  },
                                  child: const SizedBox(
                                    width: double.infinity,
                                    child: Text('Update'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context, 'Annuler');
                            },
                            child: const Text('Annuler'),
                          )
                        ],
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.edit,
                    size: 32,
                    color: Colors.green,
                  ),
                ),
                TextButton(
  onPressed: () {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmer la suppression'),
        content: const Text('Êtes-vous sûr de vouloir supprimer cet utilisateur ?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              deleteUser(allusers[index].id); // Supprime l'utilisateur en utilisant son ID
              Navigator.of(context).pop(); // Ferme la boîte de dialogue de confirmation
            },
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );
  },
  child: const Icon(
    Icons.delete,
    size: 32,
    color: Colors.red,
  ),
),

              ],
            ),
          ),
        );
      },
    );
  }
}