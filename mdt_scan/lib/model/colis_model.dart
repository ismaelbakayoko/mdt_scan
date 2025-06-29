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
  final String? nomGuichetire;
  final String? matGuichetire;
  String? matCar;
  ColisModel({
    this.id,
    this.codeGare,
    this.codeColis,
    this.refVoyage,
    this.refEnvoie,
    this.description,
    this.prixColis,
    this.photocolis,
    this.nomExpediteur,
    this.contactExpediteur,
    this.nomDestinataire,
    this.contactDestinataire,
    this.destination,
    this.valeurExtime,
    this.datecolis,
    this.envoyer,
    this.dateenvoie,
    this.codeClient,
    this.colismodifier,
    this.datemodification,
    this.colisretirer,
    this.dateretrait,
    this.colisintrouvable,
    this.colisrecu,
    this.daterecu,
    this.colisanuler,
    this.dateanulation,
    this.nomConducteur,
    this.matConducteur,
    this.nomGuichetire,
    this.matGuichetire,
    this.matCar,
    // nouveaux
  });

  factory ColisModel.fromJson(Map<String, dynamic> json) {
    return ColisModel(
      // anciens
      id: json['id'],
      codeGare: json['codegare'] ?? json['nomgare'],
      codeColis: json['codecolis'],
      refVoyage: json['refvoyage'],
      refEnvoie: json['refenvoie'],
      description: json['description'],
      prixColis: json['prixcolis'] ?? 0,
      photocolis: json['photocolis'],
      nomExpediteur: json['nomexpediteur'],
      contactExpediteur: json['contactexpediteur'],
      nomDestinataire: json['nomdestinataire'],
      contactDestinataire: json['contactdestinataire'],
      destination: json['destination'],
      valeurExtime: json['valeurestimee'] ?? 0,
      datecolis: json['datecolis'],
      envoyer: json['envoyer'] ?? false,
      dateenvoie: json['dateenvoie'],
      codeClient: json['codeclient'],
      colismodifier: json['colismodifier'] ?? false,
      datemodification: json['datemodification'],
      colisretirer: json['colisretirer'] ?? false,
      dateretrait: json['dateretrait'],
      colisintrouvable: json['colisintrouvable'] ?? false,
      colisrecu: json['colisrecu'] ?? false,
      daterecu: json['daterecu'],
      colisanuler: json['colisanuler'] ?? false,
      dateanulation: json['dateanulation'],
      nomConducteur: json['nomconducteur'],
      matConducteur: json['matconducteur'],
      nomGuichetire: json['nomgestionnairecolis'],
      matGuichetire: json['matgestionnairecolis'],
      matCar: json['matcar'] ?? json['matCar'],
    );
  }
}

class ColisModifier {
  final String? id_modifier;
  final String? codeColis_modifier;
  final String? refVoyage_modifier;
  final String? refEnvoie_modifier;
  final int? valeurExtime_modifier;
  final int? prixColis_modifier;
  final String? description_modifier;
  final String? codeClient_modifier;
  final String? nomExpediteur_modifier;
  final String? contactExpediteur_modifier;
  final String? nomDestinataire_modifier;
  final String? contactDestinataire_modifier;
  final String? datecolis_modifier;
  final String? datemodifier;
  final String? photocolis_modifier;
  final String? codeGare_modifier;
  final String? destination_modifier;
    final String? nomGuichetire;
  final String? matGuichetire;

  ColisModifier({
    this.id_modifier,
    this.codeColis_modifier,
    this.refVoyage_modifier,
    this.refEnvoie_modifier,
    this.valeurExtime_modifier,
    this.prixColis_modifier,
    this.description_modifier,
    this.codeClient_modifier,
    this.nomExpediteur_modifier,
    this.contactExpediteur_modifier,
    this.nomDestinataire_modifier,
    this.contactDestinataire_modifier,
    this.datecolis_modifier,
    this.datemodifier,
    this.photocolis_modifier,
    this.codeGare_modifier,
    this.destination_modifier,
    this.nomGuichetire,
    this.matGuichetire,
  });

  factory ColisModifier.fromJson(Map<String, dynamic> json) => ColisModifier(
        id_modifier: json['id'],
        codeColis_modifier: json['codecolis'],
        refVoyage_modifier: json['refvoyager'],
        refEnvoie_modifier: json['refenvoie'],
        valeurExtime_modifier: json['valeurestimee'],
        prixColis_modifier: json['prixcolis'],
        description_modifier: json['description'],
        codeClient_modifier: json['codeclient'],
        nomExpediteur_modifier: json['nomexpediteur'],
        contactExpediteur_modifier: json['contactexpediteur'],
        nomDestinataire_modifier: json['nomdestinataire'],
        contactDestinataire_modifier: json['contactdestinataire'],
        datecolis_modifier: json['datecolis'],
        datemodifier: json['datemodification'],
        photocolis_modifier: json['photocolis'],
        codeGare_modifier: json['codegare'],
        destination_modifier: json['destination'],
        nomGuichetire: json['nomgestionnairecolis'],
        matGuichetire: json['matgestionnairecolis'],
      );
}
