import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mdt_scan/page/Home/controller/home_controller.dart';

class PgBagage extends StatelessWidget {
  const PgBagage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final bagage = controller.listBagage.value;

    String formatDate(String? dateString) {
      if (dateString == null || dateString.isEmpty) return "Date invalide";

      try {
        DateTime date = DateTime.parse(dateString); // parse ISO format
        return DateFormat('dd/MM/yyyy').format(date);
      } catch (e) {
        return "Date invalide";
      }
    }

    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Détails du Bagage",
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
        padding: const EdgeInsets.all(10),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 4,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionTitle("Informations Générales"),
                _infoRow("Code Bagage", bagage.codeBagage),
                _infoRow("Réf. Voyage", bagage.refVoyage),
                _infoRow("Réf. Envoi", bagage.refEnvoie),
                _infoRow("Description", bagage.description),
                _infoRow("Estimation", "${bagage.valeurEstimee ?? 0} FCFA"),
                _infoRow("Prix bagage", "${bagage.prixBagage ?? 0} FCFA"),
                _infoRow("Date dépôt", formatDate(bagage.dateBagage)),
                const SizedBox(height: 10),
                _divider(),
                _sectionTitle("Statut d'envoi"),
                _infoRow("Envoyé", _boolToStr(bagage.envoyer)),
                _infoRow("Date envoi", formatDate(bagage.dateEnvoie)),
                _infoRow(
                    "Bagage introuvable", _boolToStr(bagage.bagageIntrouvable)),
                const SizedBox(height: 10),
                _divider(),
                _sectionTitle("Informations client"),
                _infoRow("Code client", bagage.codeClient),
                _infoRow("Nom client", bagage.nomClient),
                _infoRow("Contact", bagage.contactClient),
                const SizedBox(height: 10),
                _divider(),
                _sectionTitle("Détails voyage"),
                _infoRow("Siège", bagage.numSiege),
                _infoRow("Matricule car", bagage.matCar),
                _infoRow("conducteur", bagage.nomConducteur),
                _infoRow("Code gare", bagage.codeGare),
                _infoRow("Nom gare", bagage.nomGare),
                const SizedBox(height: 10),
                _divider(),
                if (bagage.photoBagage != null &&
                    bagage.photoBagage!.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionTitle("Photo du bagage"),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade300),
                          image: DecorationImage(
                            image: NetworkImage(bagage.photoBagage!),
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
        style: const TextStyle(
            fontSize: 17, fontWeight: FontWeight.bold, color: Colors.red),
      ),
    );
  }

  Widget _divider() => const Divider(thickness: 1, height: 20);

  String _boolToStr(bool? value) {
    if (value == null) return "Non renseigné";
    return value ? "Oui" : "Non";
  }
}
