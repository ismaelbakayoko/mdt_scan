import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdt_scan/component/color_config.dart';
import 'package:mdt_scan/page/Home/controller/home_controller.dart';

class PgColis extends StatelessWidget {
  const PgColis({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final colis = controller.listColi.value;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Détails du Colis"),
        backgroundColor: GColor.bleu,
        centerTitle: true,
      ),
      body: Padding(
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
                _infoRow("Code Gare", colis.codeGare),
                _infoRow("Code Colis", colis.codeColis),
                _infoRow("Réf. Voyage", colis.refVoyage),
                _infoRow("Réf. Envoi", colis.refEnvoie),
                const SizedBox(height: 10),
                _divider(),
                _sectionTitle("Description & Valeur"),
                _infoRow("Description", colis.description),
                _infoRow("Prix", "${colis.prixColis ?? 0} FCFA"),
                _infoRow("Valeur estimée", "${colis.valeurExtime ?? 0} FCFA"),
                _infoRow("Date colis", colis.datecolis),
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
                _infoRow("Date envoi", colis.dateenvoie),
                _infoRow("Colis reçu", _boolToStr(colis.colisrecu)),
                _infoRow("Date réception", colis.daterecu),
                _infoRow("Colis retiré", _boolToStr(colis.colisretirer)),
                _infoRow("Date retrait", colis.dateretrait),
                const SizedBox(height: 10),
                _divider(),
                _sectionTitle("Anomalies"),
                _infoRow("Colis annulé", _boolToStr(colis.colisanuler)),
                _infoRow("Date annulation", colis.dateanulation),
                _infoRow("Colis modifié", _boolToStr(colis.colismodifier)),
                _infoRow("Date modification", colis.datemodification),
                _infoRow(
                    "Colis introuvable", _boolToStr(colis.colisintrouvable)),
                const SizedBox(height: 10),
                _divider(),
                if (colis.photocolis != null && colis.photocolis!.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionTitle("Photo du Colis"),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        height: 180,
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
              ],
            ),
          ),
        ),
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
            child: Text(
              "$label :",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Colors.black87),
            ),
          ),
          Flexible(
            flex: 6,
            child: Text(
              value ?? "Non renseigné",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: TextStyle(
                  fontSize: 14,
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
        style: TextStyle(
            fontSize: 17, fontWeight: FontWeight.bold, color: GColor.bleu),
      ),
    );
  }

  Widget _divider() => const Divider(thickness: 1, height: 20);

  String _boolToStr(bool? value) {
    if (value == null) return "Non renseigné";
    return value ? "Oui" : "Non";
  }
}
