import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mdt_scan/component/toggle_widget.dart';
import 'package:mdt_scan/page/Home/component/full_image.dart';
import 'package:mdt_scan/page/Home/controller/home_controller.dart';
import 'package:mdt_scan/page/Home/page/Pg_home.dart';

class PgColis extends StatefulWidget {
  const PgColis({super.key});

  @override
  State<PgColis> createState() => _PgColisState();
}

class _PgColisState extends State<PgColis> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    String formatDate(String? dateString) {
      if (dateString == null || dateString.isEmpty) return "N/A";

      try {
        DateTime date = DateTime.parse(dateString); // parse ISO format
        return DateFormat('dd/MM/yyyy à HH:mm').format(date);
      } catch (e) {
        return "Date invalide";
      }
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          Get.offAll(() => const PgHome());
        }
      },
      child: Scaffold(
        appBar: AppBar(
            title: const Text("Détails du colis",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            backgroundColor: Colors.red,
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                controller.selecColis.value = false;
                controller.ctrlScan.start();
                Get.offAll(PgHome());
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30,
              ),
            )),
        body: Obx(() {
          final colis = controller.listColi.value;
          return Padding(
            padding: const EdgeInsets.all(5),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 2,
              child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionTitle("Références"),
                      _infoRow("Nom gare", colis.codeGare),
                      _infoRow("Code colis", colis.codeColis),
                      _infoRow("Réf. voyage", colis.refVoyage),
                      _infoRow("Réf. envoie", colis.refEnvoie),
                      _infoRow("Conducteur", colis.nomConducteur),
                      _infoRow("Mat. conducteur", colis.matConducteur),
                      _infoRow("Guichetière", colis.nomGuichetire),
                      _infoRow("Mat. guichetière", colis.matGuichetire),
                      const SizedBox(height: 10),
                      _divider(),
                      _sectionTitle("Description & valeur"),
                      Text(
                        "${colis.description}",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.blueGrey.shade700,
                            fontWeight: FontWeight.w500),
                      ),
                      _infoRow("Prix", "${colis.prixColis ?? 0} FCFA"),
                      _infoRow(
                          "Valeur estimée", "${colis.valeurExtime ?? 0} FCFA"),
                      _infoRow("Date colis", formatDate(colis.datecolis)),
                      _infoRow("Colis introuvable",
                          _boolToStr(colis.colisintrouvable)),
                      const SizedBox(height: 10),
                      _divider(),
                      _sectionTitle("Expéditeur"),
                      _infoRow("Nom", colis.nomExpediteur),
                      _infoRow("Contact", colis.contactExpediteur),
                      const SizedBox(height: 10),
                      _divider(),
                      _sectionTitle("Destinataire"),
                      _infoRow("Nom", colis.nomDestinataire),
                      _infoRow("Contact", colis.contactDestinataire),
                      _infoRow("Destination", colis.destination),
                      const SizedBox(height: 10),
                      _divider(),
                      _sectionTitle("Suivi"),
                      _infoRow("Envoyé", _boolToStr(colis.envoyer)),
                      _infoRow("Date envoie", formatDate(colis.dateenvoie)),
                      _infoRow("Colis reçu", _boolToStr(colis.colisrecu)),
                      _infoRow("Date réception", formatDate(colis.daterecu)),
                      _infoRow("Colis retiré", _boolToStr(colis.colisretirer)),
                      _infoRow("Date retrait", formatDate(colis.dateretrait)),
                      const SizedBox(height: 10),
                      _divider(),
                      _sectionTitle("Anomalies"),
                      _infoRow("Colis annulé", _boolToStr(colis.colisanuler)),
                      _infoRow(
                          "Date annulation", formatDate(colis.dateanulation)),
                      _infoRow(
                          "Colis modifié", _boolToStr(colis.colismodifier)),
                      _infoRow("Date modification",
                          formatDate(colis.datemodification)),
                      const SizedBox(height: 10),
                      _divider(),
                      if (colis.photocolis != null &&
                          colis.photocolis!.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _sectionTitle("Photo du Colis"),
                            GestureDetector(
                              onTap: () => Get.to(
                                () => FullScreenImage(url: colis.photocolis!),
                                transition: Transition.fade, // ou zoom
                              ),
                              child: Hero(
                                tag: colis.photocolis!, // tag unique
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  height: 200,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                    image: DecorationImage(
                                      image: NetworkImage(colis.photocolis!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      _divider(),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 6),
                        child: Text(
                          "Modifier le colis",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Flexible(
                              flex: 4,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  "Introuvable ?",
                                  maxLines: 1,
                                  softWrap: false,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      color: Colors.black87),
                                ),
                              ),
                            ),
                            SwitchToggle(
                              value: colis.colisintrouvable!,
                              onChanged: (val) async {
                                setState(() {
                                  colis.colisintrouvable = val;
                                });

                                await controller.fetchStatuColisBagage(
                                  context,
                                  id: colis.id,
                                  code: colis.codeColis,
                                  statu: colis.colisintrouvable,
                                  table: "COLIS",
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (controller.colisModifier.isNotEmpty) _divider(),
                      if (controller.colisModifier.isNotEmpty)
                        GestureDetector(
                          onTap: () => controller.selecColis.value =
                              !controller.selecColis.value,
                          child: Container(
                            height: 60,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.brown),
                            alignment: Alignment.center,
                            child: Text(
                              controller.selecColis.value == false
                                  ? "Voir les anciens enregistrements"
                                  : "Fermer les enciens enregistrements",
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (controller.colisModifier.isNotEmpty &
                              controller.selecColis.value ==
                          true)
                        Container(
                          height: 400,
                          width: double.infinity,
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            itemCount: controller.colisModifier.length,
                            itemBuilder: (context, index) {
                              final colismodif =
                                  controller.colisModifier[index];
                              return Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.15),
                                      blurRadius: 10,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Image du colis
                                    GestureDetector(
                                      onTap: () => Get.to(
                                        () => FullScreenImage(
                                            url: colismodif
                                                .photocolis_modifier!),
                                        transition: Transition.fade, // ou zoom
                                      ),
                                      child: Container(
                                        height: 80,
                                        width: 80,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          image: DecorationImage(
                                            image: NetworkImage(colismodif
                                                    .photocolis_modifier ??
                                                ""),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 16),

                                    // Infos du colis
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Modifié le :",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.blueGrey.shade600,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            formatDate(colismodif.datemodifier),
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey.shade700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Icône d'info
                                    IconButton(
                                      icon: const Icon(Icons.info_outline,
                                          color: Colors.blueGrey),
                                      tooltip: 'Voir les détails',
                                      onPressed: () {
                                        Get.defaultDialog(
                                          contentPadding: EdgeInsets.zero,
                                          titlePadding:
                                              const EdgeInsets.fromLTRB(
                                                  10, 15, 10, 0),
                                          radius: 20,
                                          backgroundColor: Colors.white,
                                          title:
                                              colismodif.codeColis_modifier ??
                                                  "Détail du colis",
                                          titleStyle: const TextStyle(
                                            color: Colors.indigo,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                          content: Container(
                                            width: Get.width * 1.0,
                                            height: Get.height * 0.6,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Scrollbar(
                                              thickness: 4,
                                              radius: const Radius.circular(10),
                                              thumbVisibility: false,
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    section(
                                                        "Informations principales"),
                                                    _info(
                                                        "Provenance",
                                                        colis.codeGare
                                                            .toString()),
                                                    _info(
                                                        "Destination",
                                                        colismodif
                                                            .destination_modifier),
                                                    _info("Tarif d'exp",
                                                        "${formatMontant(colismodif.prixColis_modifier ?? 0)} F"),
                                                    _info("Valeur estimée",
                                                        "${formatMontant(colismodif.valeurExtime_modifier ?? 0)} F"),
                                                    _info(
                                                        "Code client",
                                                        colismodif
                                                                .codeClient_modifier ??
                                                            "Aucun"),
                                                    section(
                                                        "Expéditeur / Destinataire"),
                                                    _info(
                                                        "Expéditeur",
                                                        colismodif
                                                            .nomExpediteur_modifier),
                                                    _info(
                                                        "Contact exp",
                                                        colismodif
                                                            .contactExpediteur_modifier),
                                                    _info(
                                                        "Destinataire",
                                                        colismodif
                                                            .nomDestinataire_modifier),
                                                    _info(
                                                        "Contact dest",
                                                        colismodif
                                                            .contactDestinataire_modifier),
                                                    section("Guichetière"),
                                                    _info(
                                                        "Nom guichetière",
                                                        colismodif
                                                            .nomGuichetire),
                                                    section("Description"),
                                                    Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 6,
                                                          horizontal: 8),
                                                      decoration: BoxDecoration(
                                                        color: Colors
                                                            .grey.shade100,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: Text(
                                                        colismodif
                                                                .description_modifier ??
                                                            "Aucune description",
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.blueGrey
                                                              .shade800,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                    ],
                  )),
            ),
          );
        }),
      ),
    );
  }

  Widget _info(String title, String? value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 3),
      width: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        children: [
          Text(
            "$title :",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: Colors.black87,
            ),
          ),
          Text(
            value ?? "Non renseigné",
            style: TextStyle(
              fontSize: 13,
              color: Colors.deepOrange.shade800,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 4,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "$label :",
                maxLines: 1,
                softWrap: false,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Colors.black87),
              ),
            ),
          ),
          Flexible(
            flex: 6,
            child: Text(
              value ?? "Non renseigné",
              maxLines: 1,
              softWrap: false,
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.blueGrey.shade700,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 17, fontWeight: FontWeight.bold, color: Colors.red),
      ),
    );
  }

  Widget section(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
          color: Colors.indigo,
        ),
      ),
    );
  }

  Widget _divider() => const Divider(thickness: 1, height: 20);

  String _boolToStr(bool? value) {
    if (value == null) return "Non renseigné";
    return value ? "Oui" : "Non";
  }

  String formatMontant(int montant) {
    return NumberFormat("#,##0", "fr_FR").format(montant);
  }
}
