class ColisModifieModel {
  String? id;
  String? codeColis;
  String? refVoyage;
  String? refEnvoie;
  int? valeurEstimee;
  int? prixColis;
  String? description;
  String? codeClient;
  String? nomExpediteur;
  String? contactExpediteur;
  String? nomDestinataire;
  String? contactDestinataire;
  String? destination;
  DateTime? dateColis;
  String? photoColis;
  String? codeGare;
  String? matGestionnaireColis;
  DateTime? dateModification;

  ColisModifieModel({
    this.id,
    this.codeColis,
    this.refVoyage,
    this.refEnvoie,
    this.valeurEstimee,
    this.prixColis,
    this.description,
    this.codeClient,
    this.nomExpediteur,
    this.contactExpediteur,
    this.nomDestinataire,
    this.contactDestinataire,
    this.destination,
    this.dateColis,
    this.photoColis,
    this.codeGare,
    this.matGestionnaireColis,
    this.dateModification,
  });

  factory ColisModifieModel.fromJson(Map<String, dynamic> json) {
    return ColisModifieModel(
      id: json['id'],
      codeColis: json['codecolis'],
      refVoyage: json['refvoyage'],
      refEnvoie: json['refenvoie'],
      valeurEstimee: json['valeurestimee'],
      prixColis: json['prixcolis'],
      description: json['description'],
      codeClient: json['codeclient'],
      nomExpediteur: json['nomexpediteur'],
      contactExpediteur: json['contactexpediteur'],
      nomDestinataire: json['nomdestinataire'],
      contactDestinataire: json['contactdestinataire'],
      destination: json['destination'],
      dateColis: json['datecolis'] != null ? DateTime.parse(json['datecolis']) : null,
      photoColis: json['photocolis'],
      codeGare: json['codegare'],
      matGestionnaireColis: json['matgestionnairecolis'],
      dateModification: json['datemodification'] != null
          ? DateTime.parse(json['datemodification'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'codecolis': codeColis,
      'refvoyage': refVoyage,
      'refenvoie': refEnvoie,
      'valeurestimee': valeurEstimee,
      'prixcolis': prixColis,
      'description': description,
      'codeclient': codeClient,
      'nomexpediteur': nomExpediteur,
      'contactexpediteur': contactExpediteur,
      'nomdestinataire': nomDestinataire,
      'contactdestinataire': contactDestinataire,
      'destination': destination,
      'datecolis': dateColis?.toIso8601String(),
      'photocolis': photoColis,
      'codegare': codeGare,
      'matgestionnairecolis': matGestionnaireColis,
      'datemodification': dateModification?.toIso8601String(),
    };
  }
}
