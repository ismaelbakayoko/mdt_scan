import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdt_scan/page/Home/controller/home_controller.dart';
import 'package:intl/intl.dart';

class PgColisModifier extends StatelessWidget {
  const PgColisModifier({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final colis = controller.colisModifier.value;

    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Colis modifié",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
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
          )),
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
                _sectionTitle("Informations Colis"),
                _infoRow("Code colis", colis.codeColis),
                _infoRow("Réf.voyage", colis.refVoyage),
                _infoRow("Réf.envoi", colis.refEnvoie),
                _infoRow("Description", colis.description),
                _infoRow("Prix", "${colis.prixColis ?? 0} FCFA"),
                _infoRow("Valeur estimée", "${colis.valeurEstimee ?? 0} FCFA"),
                _infoRow("Date colis", _formatDate(colis.dateColis)),
                _infoRow(
                    "Date modification", _formatDate(colis.dateModification)),
                const SizedBox(height: 10),
                _divider(),
                _sectionTitle("Informations Expéditeur"),
                _infoRow("Nom", colis.nomExpediteur),
                _infoRow("Contact", colis.contactExpediteur),
                _infoRow("Code client", colis.codeClient),
                const SizedBox(height: 10),
                _divider(),
                _sectionTitle("Informations Destinataire"),
                _infoRow("Nom", colis.nomDestinataire),
                _infoRow("Contact", colis.contactDestinataire),
                _infoRow("Destination", colis.destination),
                const SizedBox(height: 10),
                _divider(),
                _sectionTitle("Autres"),
                _infoRow("Code gare", colis.codeGare),
                _infoRow("Mat gestionnaire", colis.matGestionnaireColis),
                const SizedBox(height: 10),
                _divider(),
                if (colis.photoColis != null && colis.photoColis!.isNotEmpty)
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
                            image: NetworkImage(colis.photoColis!),
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
        style: const TextStyle(
            fontSize: 17, fontWeight: FontWeight.bold, color: Colors.red),
      ),
    );
  }

  Widget _divider() => const Divider(thickness: 1, height: 20);

  String _formatDate(DateTime? date) {
    if (date == null) return "Non renseignée";
    return DateFormat('dd/MM/yyyy à HH:mm').format(date);
  }
}
