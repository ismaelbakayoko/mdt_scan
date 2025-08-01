import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdt_scan/page/Home/component/full_image.dart';
import 'package:mdt_scan/page/Home/controller/home_controller.dart';
import 'package:intl/intl.dart';
import 'package:mdt_scan/page/Home/page/Pg_home.dart';

class PgColisAnnuler extends StatelessWidget {
  const PgColisAnnuler({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final colis = controller.colisAnnuler.value;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          Get.offAll(() => const PgHome());
        }
      },
      child: Scaffold(
        appBar: AppBar(
            title: const Text("Colis annulé",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            backgroundColor: Colors.red,
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                controller.ctrlScan.start();
                Get.offAll(PgHome());
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
                  _sectionTitle("Références"),
                  _infoRow("Code colis", colis.codeColis),
                  _infoRow("Réf. voyage", colis.refVoyage),
                  _infoRow("Nom gare", colis.codeGare),
                  const SizedBox(height: 10),
                  _sectionTitle("Description & valeur"),
                  Text(
                    "${colis.description}",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.blueGrey.shade700,
                        fontWeight: FontWeight.w500),
                  ),
                  _infoRow("Prix", "${colis.prixcolis ?? 0} FCFA"),
                  _infoRow(
                      "Valeur estimée", "${colis.valeurestimee ?? 0} FCFA"),
                  _infoRow("Date colis", _formatDate(colis.datecolis)),
                  _divider(),
                  _sectionTitle("Détails de l'annulation"),
                  _infoRow("Motif", colis.motifAnnulation),
                  _infoRow(
                      "Frais annulation", "${colis.montantRetenu ?? 0} FCFA"),
                  _infoRow(
                      "Remise appliquée", "${colis.remiseAnnulation ?? 0} %"),
                  _infoRow(
                      "Date d'annulation", _formatDate(colis.dateAnnulation)),
                  const SizedBox(height: 10),
                  _divider(),
                  _sectionTitle("Gestion"),
                  _infoRow("Nom gestionnaire", colis.nomGestionnaireColis),
                  _infoRow("Mat. gestionnaire", colis.matGestionnaireColis),
                  _infoRow("Payé en ligne", _boolToStr(colis.payerEnLigne)),
                  if (colis.photocolis != null && colis.photocolis!.isNotEmpty)
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _sectionTitle("Photo du Colis"),
                          GestureDetector(
                            onTap: () => Get.to(
                              () => FullScreenImage(url: colis.photocolis!),
                              transition: Transition.fade, // ou zoom
                            ),
                            child: Container(
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
                          ),
                        ])
                ],
              ),
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

  Widget _divider() => const Divider(thickness: 1, height: 20);

  String _formatDate(DateTime? date) {
    if (date == null) return "Non renseignée";
    return DateFormat('dd/MM/yyyy à HH:mm').format(date);
  }

  String _boolToStr(bool? value) {
    if (value == null) return "Non renseigné";
    return value ? "Oui" : "Non";
  }
}
