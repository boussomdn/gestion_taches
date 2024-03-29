import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gestion_taches/model/Taches.dart';

Future<void> addUser(Tache tache) async {
  try {
    final docTache = FirebaseFirestore.instance.collection("taches").doc();
    tache.id = docTache.id;

    await docTache.set(tache.toJson());
  } catch (e) {
    // ignore: avoid_print
    print("Erreur lors de l'ajout de la tache : $e");
  }
}
//Fonction pour modifier
Future<void> updateUser(Tache tache) async {
  try{
    final docTache = FirebaseFirestore.instance.collection('taches').doc(tache.id);
    await docTache.update(tache.toJson());
  }catch (e) {
    // ignore: avoid_print
    print("Erreur lors de la modification de la tache : $e");
  }
}
Future<void> deleteUser(String tacheId) async {
  try {
    await FirebaseFirestore.instance.collection('taches').doc(tacheId).delete();
    print('Tache supprimé avec succès.');
  } catch (e) {
    print("Erreur lors de la suppression de la tache : $e");
  }
}