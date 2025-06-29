class ColisAnnuleModel {
  final String? id;
  final String? codeColis;
  final String? motifAnnulation;
  final int? remiseAnnulation;
  final DateTime? dateAnnulation;
  final String? matGestionnaireColis;
  final int? montantRetenu;
  final String? refVoyage;
  final String? codeGare;
  final bool? payerEnLigne;
  final String? nomGestionnaireColis;
  final int? valeurestimee;
  final int? prixcolis;
  final String? description;
  final String? codeclient;
  final String? nomexpediteur;
  final String? contactexpediteur;
  final String? nomdestinataire;
  final String? contactdestinataire;
  final String? destination;
  final DateTime? datecolis;
  final String? photocolis;
  final String? matgestionnairecolis;
  final String? nomgestionnairecolis;


  ColisAnnuleModel({
    this.id,
    this.codeColis,
    this.motifAnnulation,
    this.remiseAnnulation,
    this.dateAnnulation,
    this.matGestionnaireColis,
    this.montantRetenu,
    this.refVoyage,
    this.codeGare,
    this.payerEnLigne,
    this.nomGestionnaireColis,
    this.valeurestimee,
    this.prixcolis,
    this.description,
    this.codeclient,
    this.nomexpediteur,
    this.contactexpediteur,
    this.nomdestinataire,
    this.contactdestinataire,
    this.destination,
    this.datecolis,
    this.photocolis,
    this.matgestionnairecolis,
    this.nomgestionnairecolis,
    
  });

  factory ColisAnnuleModel.fromJson(Map<String, dynamic> json) {
    return ColisAnnuleModel(
      id: json['id'] as String,
      codeColis: json['codecolis'] as String,
      motifAnnulation: json['motifannulation'] as String,
      remiseAnnulation: json['remiseannulation'] as int,
      dateAnnulation: json['dateannulation'] != null
          ? DateTime.parse(json['dateannulation'])
          : null,
      matGestionnaireColis: json['matgestionnairecolis'] as String,
      nomGestionnaireColis: json['nomgestionnairecolis'] as String,
      montantRetenu: json['montantretenu'],
      refVoyage: json['refvoyage'],
      codeGare: json['nomgare'],
      payerEnLigne: json['payerenligne'] == true,
      valeurestimee: json['valeurestimee'],
      prixcolis: json['prixcolis'],
      description: json['description'],
      codeclient: json['codeclient'],
      nomexpediteur: json['nomexpediteur'],
      contactexpediteur: json['contactexpediteur'],
      nomdestinataire: json['nomdestinataire'],
      contactdestinataire: json['contactdestinataire'],
      destination: json['destination'],
      datecolis: json['datecolis'] != null
          ? DateTime.parse(json['datecolis'])
          : null,
      photocolis: json['photocolis'],
      matgestionnairecolis: json['matgestionnairecolis'],
      nomgestionnairecolis: json['nomgestionnairecolis'],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'codecolis': codeColis,
      'motifannulation': motifAnnulation,
      'remiseannulation': remiseAnnulation,
      'dateannulation': dateAnnulation?.toIso8601String(),
      'matgestionnairecolis': matGestionnaireColis,
      'montantretenu': montantRetenu,
      'refvoyage': refVoyage,
      'codegare': codeGare,
      'payerenligne': payerEnLigne ?? false,
    };
  }
}
