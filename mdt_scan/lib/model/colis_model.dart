class ColisModel {
  final String? id;
  final String? codeGare;
  final String? codeColis;
  final String? refVoyage;
  final String? refEnvoie;
  final String? description;
  final int? prixColis;
  final String? photocolis;
  final String? nomExpediteur;
  final String? contactExpediteur;
  final String? nomDestinataire;
  final String? contactDestinataire;
  final String? destination;
  final int? valeurExtime;
  final String? datecolis;
  final bool? envoyer;
  final String? dateenvoie;
  final String? codeClient;
  final bool? colismodifier;
  final String? datemodification;
  final bool? colisretirer;
  final String? dateretrait;
   bool? colisintrouvable;
  final bool? colisrecu;
  final String? daterecu;
  final bool? colisanuler;
  final String? dateanulation;
  String? nomConducteur;
  String? matConducteur;
  String? matCar;

  ColisModel({
    this.id,
    this.codeGare,
    this.codeColis,
    this.refVoyage,
    this.refEnvoie,
    this.description,
    this.photocolis,
    this.prixColis,
    this.nomExpediteur,
    this.contactExpediteur,
    this.nomDestinataire,
    this.contactDestinataire,
    this.destination,
    this.valeurExtime,
    this.colisintrouvable,
    this.codeClient,
    this.colismodifier,
    this.datemodification,
    this.colisretirer,
    this.dateretrait,
    this.datecolis,
    this.envoyer,
    this.dateenvoie,
    this.colisrecu,
    this.daterecu,
    this.colisanuler,
    this.dateanulation,
    this.nomConducteur,
    this.matConducteur,
    this.matCar,
  });

  factory ColisModel.fromJson(Map<String, dynamic> json) {
    return ColisModel(
      id: json['id'],
      codeGare: json['nomgare'] ,
      codeColis: json['codecolis'] ,
      refVoyage: json['refvoyage'] ,
      refEnvoie: json['refenvoie'] ,
      description: json['description'] ,
      prixColis: json['prixcolis'] ?? 0,
      photocolis: json['photocolis'],
      nomExpediteur: json['nomexpediteur'] ,
      contactExpediteur: json['contactexpediteur'] ,
      nomDestinataire: json['nomdestinataire'] ,
      contactDestinataire: json['contactdestinataire'] ,
      destination: json['destination'] ,
      valeurExtime: json['valeurestimee'] ?? 0,
      codeClient: json['codeclient'] ,
      colisintrouvable: json['colisintrouvable'] ?? false,
      colismodifier: json['colismodifier'] ?? false,
      datemodification: json['datemodification'] ,
      colisretirer: json['colisretirer'] ?? false,
      dateretrait: json['dateretrait'] ,
      datecolis: json['datecolis'],
      envoyer: json['envoyer'] ?? false,
      dateenvoie: json['dateenvoie'] ,
      colisrecu: json['colisrecu'] ?? false,
      daterecu: json['daterecu'] ,
      colisanuler: json['colisanuler'] ?? false,
      dateanulation: json['dateanulation'],
      nomConducteur: json['nomconducteur'],
      matConducteur: json['matconducteur'],
      matCar: json['matcar'] ?? json['matCar'],
    );
  }
}
