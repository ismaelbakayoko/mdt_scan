class BagagesModel {
  final String? id;
  final String? codeBagage;
  final String? refVoyage;
  final String? refEnvoie;
  final int? valeurEstimee;
  final int? prixBagage;
  final String? description;
  final String? dateBagage;
  final String? photoBagage;
  final bool? envoyer;
  final String? dateEnvoie;
  final String? codeClient;
  final String? nomClient;
  final String? contactClient;
  final String? numSiege;
  final String? matCar;
  final String? nomConducteur;
  final String? matConducteur;
  final String? codeGare;
  final String? nomGare;
  bool? bagageIntrouvable;

  BagagesModel({
    this.id,
    this.codeBagage,
    this.refVoyage,
    this.refEnvoie,
    this.valeurEstimee,
    this.prixBagage,
    this.description,
    this.dateBagage,
    this.photoBagage,
    this.envoyer,
    this.dateEnvoie,
    this.codeClient,
    this.nomClient,
    this.contactClient,
    this.numSiege,
    this.matCar,
    this.nomConducteur,
    this.matConducteur,
    this.codeGare,
    this.nomGare,
    this.bagageIntrouvable,
  });

  factory BagagesModel.fromJson(Map<String, dynamic> json) {
    return BagagesModel(
      id: json['id'],
      codeBagage: json['codebagage'] ?? '',
      refVoyage: json['refvoyage'] ?? '',
      refEnvoie: json['refenvoie'] ?? '',
      valeurEstimee: (json['valeurestimee'] ?? 0),
      prixBagage: (json['prixbagage'] ?? 0),
      description: json['description'] ?? '',
      dateBagage: json['datebagage'] ?? '',
      photoBagage: json['photobagage'] ?? '',
      envoyer: json['envoyer'] ?? false,
      dateEnvoie: json['dateenvoie'] ?? '',
      codeClient: json['codeclient'] ?? '',
      nomClient: json['nomclient'] ?? '',
      contactClient: json['contactclient'] ?? '',
      numSiege: json['numsiege'] ?? '',
      matCar: json['matcar'],
      nomConducteur: json['nomconducteur'],
      matConducteur: json['matconducteur'],
      codeGare: json['codegare'] ?? '',
      nomGare: json['gares']?['nomgare'] ?? '',
      bagageIntrouvable: json['bagageintrouvable'] ?? false,
    );
  }
}
