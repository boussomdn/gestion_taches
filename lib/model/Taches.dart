enum StatutTache {
  pasDebutee,
  enCours,
  terminee,
}
class Tache { 
  String id;
  String titre;
  String description;
  DateTime dateDebut;
  DateTime dateFin;
 
  StatutTache status;

  Tache({ 
    this.id = '',
    required this.titre,
    required this.description,
    required this.dateDebut,
    required this.dateFin,
   
    this.status = StatutTache.pasDebutee,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titre': titre,
      'description': description,
      'dateDebut': dateDebut.toIso8601String(),
      'dateFin': dateFin.toIso8601String(),
    };
  }

  factory Tache.fromJson(Map<String, dynamic> json) {
    return Tache(
      id: json['id'],
      titre: json['titre'],
      description: json['description'],
      dateDebut: DateTime.parse(json['dateDebut']),
      dateFin: DateTime.parse(json['dateFin']),
      
    );
  }
}