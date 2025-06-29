import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mdt_scan/component/toggle_widget.dart';
import 'package:mdt_scan/page/Home/controller/home_controller.dart';

class PgBagage extends StatefulWidget {
  const PgBagage({super.key});

  @override
  State<PgBagage> createState() => _PgBagageState();
}

class _PgBagageState extends State<PgBagage> {
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
          title: const Text(
            "Détails du bagage",
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
      body: Obx(() {
        final bagage = controller.listBagage.value;
        return Padding(
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
                  _sectionTitle("Références"),
                  _infoRow("Code bagage", bagage.codeBagage),
                  _infoRow("Réf. voyage", bagage.refVoyage),
                  _infoRow("Réf. envoie", bagage.refEnvoie),
                  _infoRow("Matricule car", bagage.matCar),
                  _infoRow("conducteur", bagage.nomConducteur),

                  _infoRow("Date enrg", formatDate(bagage.dateBagage)),
                  const SizedBox(height: 10),
                  _divider(),
                  _sectionTitle("Suivi"),
                  _infoRow("Mis dans le car", _boolToStr(bagage.envoyer)),
                  _infoRow("Date envoie", formatDate(bagage.dateEnvoie)),
                  _infoRow("Introuvable", _boolToStr(bagage.bagageIntrouvable)),

                  _divider(),
                  _sectionTitle("Description & valeur"),
                  Text(
                    bagage.description.toString(),
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.blueGrey.shade700,
                        fontWeight: FontWeight.w500),
                  ),
                  _infoRow("Estimation", "${bagage.valeurEstimee ?? 0} FCFA"),
                  _infoRow("Prix bagage", "${bagage.prixBagage ?? 0} FCFA"),
                  const SizedBox(height: 10),
                  _divider(),
                  _sectionTitle("Informations client"),
                  _infoRow("Code client", bagage.codeClient),
                  _infoRow("Siège", bagage.numSiege),
                  // _infoRow("Nom client", bagage.nomClient),
                  _infoRow("Contact", bagage.contactClient),

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
                  const SizedBox(
                    height: 10,
                  ),
                  _divider(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(
                      "Modifier le bagage",
                      style: const TextStyle(
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
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: Colors.black87),
                            ),
                          ),
                        ),
                        SwitchToggle(
                          value: bagage.bagageIntrouvable!,
                          onChanged: (val) async {
                            setState(() {
                              bagage.bagageIntrouvable = val;
                            });

                            await controller.fetchStatuColisBagage(
                              context,
                              id: bagage.id,
                              code: bagage.codeBagage,
                              statu: bagage.bagageIntrouvable,
                              table: "BAGAGE",
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
