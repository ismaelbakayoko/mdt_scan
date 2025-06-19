class TicketModel {
  String? id;
  String? refVoyage;
  String? refVoyageRemplace;
  String? numSiege;
  String? numSiegeRemplace;
  String? nomGare;
  String? destination;
  String? typeTicket;
  int? prixTicket;
  String? contactClient;
  String? codeClient;
  String? matCar;
  String? matCarRemplace;
  String? dateTicket;
  String? matGuichetiere;
  String? nomGuichetiere;
  String? prenomsGuichetiere;
  bool? ticketUtiliser;
  bool? clientBagage;
  bool? isRemplaced;
  bool? siegeVacant;
  bool? oldAbsent;
  bool? paiementEnLigne;

  TicketModel({
    this.id,
    this.refVoyage,
    this.refVoyageRemplace,
    this.numSiegeRemplace,
    this.numSiege,
    this.siegeVacant,
    this.nomGare,
    this.destination,
    this.typeTicket,
    this.prixTicket,
    this.contactClient,
    this.codeClient,
    this.matCar,
    this.matCarRemplace,
    this.oldAbsent,
    this.dateTicket,
    this.matGuichetiere,
    this.nomGuichetiere,
    this.prenomsGuichetiere,
    this.ticketUtiliser,
    this.clientBagage,
    this.isRemplaced,
    this.paiementEnLigne,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    print(json);
    return TicketModel(
      id: json['id'],
      refVoyage: json['refvoyage'] ?? json['refVoyage'],
      refVoyageRemplace: json['refvoyageremplacement'],
      numSiegeRemplace: json['newnumsiege'],
      numSiege: json['numsiege'] ?? json['numSiege'],
      nomGare: json['nomgare'] ?? json['nomGare'],
      destination: json['destination'],
      paiementEnLigne: json['payerenligne'] ?? false,
      typeTicket:
          (json['typeticket'] ?? json['typeTicket']).toString().toUpperCase(),
      prixTicket: json['prixticket'] ?? json['prixTicket'],
      contactClient: json['contactclient'] ?? json['contactClient'],
      codeClient: json['codeclient'] ?? json['codeClient'],
      matCar: json['matcar'] ?? json['matCar'],
      matCarRemplace: json['matcar_remplacement'],
      siegeVacant: json['siegevacant'] ?? json['siegeVacant'],
      oldAbsent: json['etaitabsent'],
      ticketUtiliser: json['ticketutiliser'] ?? json['ticketUtiliser'],
      clientBagage: json['clientbagage'] ?? json['clientBagage'],
      isRemplaced: json['isRemplaced'] ?? json['isremplaced'],
      dateTicket: json['dateticket'] ?? json['dateTicket'],
      matGuichetiere: json['matguichetiere'] ?? json['matGuichetiere'],
      nomGuichetiere: json['nomguichetiere'] ?? json['nomGuichetiere'],
      prenomsGuichetiere:
          json['prenomsguichetiere'] ?? json['prenomsGuichetiere'],
    );
  }
}
