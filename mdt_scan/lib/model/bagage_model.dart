class BagagesModel {
  final String? codeBagage;
  final String? refVoyage;
  final String? refEnvoie;
  final double? valeurEstimee;
  final double? prixBagage;
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
  final String? codeGare;
  final String? nomGare;
  final bool? bagageIntrouvable;

  BagagesModel({
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
     this.codeGare,
     this.nomGare,
     this.bagageIntrouvable,
  });

  factory BagagesModel.fromJson(Map<String, dynamic> json) {
    return BagagesModel(
      codeBagage: json['codebagage'] ?? '',
      refVoyage: json['refvoyage'] ?? '',
      refEnvoie: json['refenvoie'] ?? '',
      valeurEstimee: (json['valeurestimee'] ?? 0).toDouble(),
      prixBagage: (json['prixbagage'] ?? 0).toDouble(),
      description: json['description'] ?? '',
      dateBagage: json['datebagage'] ?? '',
      photoBagage: json['photobagage'] ?? '',
      envoyer: json['envoyer'] ?? false,
      dateEnvoie: json['dateenvoie'] ?? '',
      codeClient: json['codeclient'] ?? '',
      nomClient: json['nomclient'] ?? '',
      contactClient: json['contactclient'] ?? '',
      numSiege: json['numsiege'] ?? '',
      matCar: json['ref_voyages']?['carremplacement'] ??
          json['ref_voyages']?['matcar'] ??
          '',
      nomConducteur: json['ref_voyages']?['conducteurremplacement'] ??
          json['ref_voyages']?['nomconducteur'] ??
          '',
      codeGare: json['codegare'] ?? '',
      nomGare: json['gares']?['nomgare'] ?? '',
      bagageIntrouvable: json['bagageintrouvable'] ?? false,
    );
  }
}
