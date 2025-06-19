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
      montantRetenu: json['montantretenu'],
      refVoyage: json['refvoyage'],
      codeGare: json['codegare'],
      payerEnLigne: json['payerenligne'] == true,
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
