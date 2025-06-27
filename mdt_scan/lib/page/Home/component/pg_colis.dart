import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mdt_scan/component/toggle_widget.dart';
import 'package:mdt_scan/page/Home/controller/home_controller.dart';

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
      if (dateString == null || dateString.isEmpty) return "Date invalide";

      try {
        DateTime date = DateTime.parse(dateString); // parse ISO format
        return DateFormat('dd/MM/yyyy à HH:mm').format(date);
      } catch (e) {
        return "Date invalide";
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Détails du Colis",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.red,
        centerTitle: true,
         leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30,
            ),
          )
      ),
      body: Obx(() {
        final colis = controller.listColi.value;
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionTitle("Références"),
                  _infoRow("Nom Gare", colis.codeGare),
                  _infoRow("Code Colis", colis.codeColis),
                  _infoRow("Réf. Voyage", colis.refVoyage),
                  _infoRow("Réf. Envoi", colis.refEnvoie),
                  _infoRow("Conducteur", colis.nomConducteur),
                  _infoRow("Mat conducteur", colis.matConducteur),
                  const SizedBox(height: 10),
                  _divider(),
                  _sectionTitle("Description & Valeur"),
                  _infoRow("Description", colis.description),
                  _infoRow("Prix", "${colis.prixColis ?? 0} FCFA"),
                  _infoRow("Valeur estimée", "${colis.valeurExtime ?? 0} FCFA"),
                  _infoRow("Date colis", formatDate(colis.datecolis)),
                   _infoRow("Colis introuvable", _boolToStr(colis.colisintrouvable)),
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
                  _infoRow("Date envoi", formatDate(colis.dateenvoie)),
                  _infoRow("Colis reçu", _boolToStr(colis.colisrecu)),
                  _infoRow("Date réception", formatDate(colis.daterecu)),
                  _infoRow("Colis retiré", _boolToStr(colis.colisretirer)),
                  _infoRow("Date retrait", formatDate(colis.dateretrait)),
                  const SizedBox(height: 10),
                  _divider(),
                  _sectionTitle("Anomalies"),
                  _infoRow("Colis annulé", _boolToStr(colis.colisanuler)),
                  _infoRow("Date annulation", formatDate(colis.dateanulation)),
                  _infoRow("Colis modifié", _boolToStr(colis.colismodifier)),
                  _infoRow("Date modification", formatDate(colis.datemodification)),
                  const SizedBox(height: 10),
                  _divider(),
                  if (colis.photocolis != null && colis.photocolis!.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _sectionTitle("Photo du Colis"),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade300),
                            image: DecorationImage(
                              image: NetworkImage(colis.photocolis!),
                              fit: BoxFit.cover,
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
                ],
              ),
            ),
          ),
        );
      }),
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
        style:const TextStyle(
            fontSize: 17, fontWeight: FontWeight.bold, color:Colors.red),
      ),
    );
  }

  Widget _divider() => const Divider(thickness: 1, height: 20);

  String _boolToStr(bool? value) {
    if (value == null) return "Non renseigné";
    return value ? "Oui" : "Non";
  }
}
