class ConvoiModel {
  String? id;
  String? codeGare;
  String? nomGare;
  String? refConvoi;
  String? villeDepart;
  String? villeArrivee;
  int? distance;
  String? typeConvoi;
  int? nbrePlaces;
  int? nbreCars;
  int? prixPratiquer;
  int? reduction;
  DateTime? dateEnrg;
  DateTime? dateDebut;
  DateTime? dateRetour;
  int? montantConvoi;
  bool? montantSolder;
  String? matUser;
  String? nomRepresentant;
  String? contactRepresentant;
  String? heureDepart;
  String? heureRetour;
  String? numCni;
  int? montAvances;
  int? montantBrute;
  int? reste;
  List<Avance>? avance;
  List<Typecarmodel>? typescarsconvois;
  List<CarConvoiNonModel>? carConvoi;

  ConvoiModel({
    this.id,
    this.codeGare,
    this.nomGare,
    this.refConvoi,
    this.villeDepart,
    this.villeArrivee,
    this.distance,
    this.typeConvoi,
    this.nbrePlaces,
    this.nbreCars,
    this.prixPratiquer,
    this.reduction,
    this.dateEnrg,
    this.dateDebut,
    this.dateRetour,
    this.montantConvoi,
    this.montantSolder,
    this.matUser,
    this.nomRepresentant,
    this.contactRepresentant,
    this.numCni,
    this.montAvances,
    this.montantBrute,
    this.heureDepart,
    this.heureRetour,
    this.reste,
    this.avance,
    this.typescarsconvois,
    this.carConvoi,
  });

  factory ConvoiModel.fromJson(Map<String, dynamic> json) {
    var dataAvance = json['avances_convois'] as List;
    var dataTypescarsconvois = json['types_cars_convois'] as List;
    var dataCarConducteur = json['cars_convois'] as List;
    return ConvoiModel(
      id: json['id'],
      codeGare: json['codegare'],
      nomGare: json['nomgare'],
      refConvoi: json['refconvoi'] ?? "...",
      villeDepart: json['villedepart'] ?? "",
      villeArrivee: json['villearrivee'] ?? "",
      distance: json['distance'] ?? 0,
      typeConvoi: json['typeconvoi'] ?? "",
      nbrePlaces: json['nbreplaces'] ?? 0,
      nbreCars: json['nbrecars'] ?? 0,
      prixPratiquer: json['prixpratiquer'] ?? 0,
      reduction: json['reduction'] ?? 0,
      dateEnrg: DateTime.parse(json['dateenrg'] ?? 00 / 0 / 00),
      dateDebut: DateTime.parse(json['datedebut'] ?? 00 / 0 / 00),
      dateRetour: DateTime.parse(json['dateretour'] ?? 00 / 0 / 00),
      montantConvoi: json['montantconvoi'] ?? 0,
      montAvances: json['montAvances'] ?? 0,
      montantBrute: json['montantBrute'] ?? 0,
      heureDepart: json['heureDepart'] ?? "",
      heureRetour: json['heureRetour'] ?? "",
      montantSolder: json['montantsolder'] ?? false,
      matUser: json['matuser'],
      nomRepresentant: json['nomrepresentant'] ?? "",
      contactRepresentant: json['contactrepresentant'] ?? "",
      numCni: json['numcni'] ?? "",
      reste: json['reste'] ?? 0,
      avance:
          dataAvance.map((jsonAvance) => Avance.fromJson(jsonAvance)).toList(),

      typescarsconvois: dataTypescarsconvois
          .map((jsontypeConvoi) => Typecarmodel.fromJson(jsontypeConvoi))
          .toList(), // json['typescarsconvois'],
      carConvoi: dataCarConducteur
          .map((jsoncarConvoi) => CarConvoiNonModel.fromJson(jsoncarConvoi))
          .toList(),
    );
  }
}

class Avance {
  int? avance;

  Avance({
    this.avance,
  });

  factory Avance.fromJson(Map<String, dynamic> json) {
    return Avance(
      avance: json['avance'] ?? 0,
    );
  }
}

class Typecarmodel {
  String? id;
  String? refConvoi;
  String? typecar;
  int? nbrecars;
  int? nbreplaces;

  Typecarmodel({
    this.id,
    this.typecar,
    this.refConvoi,
    this.nbrecars,
    this.nbreplaces,
  });

  factory Typecarmodel.fromJson(Map<String, dynamic> json) {
    return Typecarmodel(
      id: json['id'],
      typecar: json['typecar'] ?? "",
      nbrecars: json['nbrecars'] ?? 0,
      nbreplaces: json['nbreplaces'] ?? 0,
    );
  }
}

class CarConvoiNonModel {
  String? matcar;
  int? nbresieges;
  String? matconducteur;
  String? nomconducteur;

  CarConvoiNonModel({
    this.matcar,
    this.nbresieges,
    this.matconducteur,
    this.nomconducteur,
  });

  factory CarConvoiNonModel.fromJson(Map<String, dynamic> json) {
    return CarConvoiNonModel(
      matcar: json['matcar'],
      nbresieges: json['nbresieges'] ?? 0,
      nomconducteur: json['nomconducteur'] ?? "",
      matconducteur: json['matconducteur'] ?? "",
    );
  }
}
