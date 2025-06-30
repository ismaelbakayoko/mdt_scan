import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mdt_scan/component/color_config.dart';
import 'package:mdt_scan/page/Home/controller/home_controller.dart';
import 'package:mdt_scan/page/Home/page/Pg_home.dart';

class PgConvoi extends StatelessWidget {
  const PgConvoi({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final convoi = controller.listConvoi.value;

    return PopScope(
       canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          Get.offAll(() => const PgHome()); 
        }
      },

      child: Scaffold(
        appBar: AppBar(
          title: const Text("Détails du Convoi"),
          backgroundColor: GColor.bleu,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionTitle("Infos Convoi"),
                  _info("Référence", convoi.refConvoi),
                  _info("Type", convoi.typeConvoi),
                  _info("Ville de départ", convoi.villeDepart),
                  _info("Ville d’arrivée", convoi.villeArrivee),
                  _info("Distance", "${convoi.distance} km"),
                  _info("Gare", "${convoi.nomGare} (${convoi.codeGare})"),
                  _info("Date d'enregistrement", _formatDate(convoi.dateEnrg)),
                  _info("Départ", "${_formatDate(convoi.dateDebut)} à ${convoi.heureDepart}"),
                  _info("Retour", "${_formatDate(convoi.dateRetour)} à ${convoi.heureRetour}"),
                  const SizedBox(height: 10),
                  _divider(),
      
                  _sectionTitle("Informations financières"),
                  _info("Prix pratiqué", "${convoi.prixPratiquer} FCFA"),
                  _info("Réduction", "${convoi.reduction}%"),
                  _info("Montant brut", "${convoi.montantBrute} FCFA"),
                  _info("Avances", "${convoi.montAvances} FCFA"),
                  _info("Montant total", "${convoi.montantConvoi} FCFA"),
                  _info("Montant soldé", convoi.montantSolder == true ? "Oui" : "Non"),
                  _info("Reste à solder", "${convoi.reste} FCFA"),
                  const SizedBox(height: 10),
                  _divider(),
      
                  _sectionTitle("Représentant"),
                  _info("Nom", convoi.nomRepresentant),
                  _info("Contact", convoi.contactRepresentant),
                  _info("CNI", convoi.numCni),
                  const SizedBox(height: 10),
                  _divider(),
      
                  if ((convoi.avance ?? []).isNotEmpty) ...[
                    _sectionTitle("Avances enregistrées"),
                    ...convoi.avance!.map((a) => _info("Avance", "${a.avance} FCFA")).toList(),
                    const SizedBox(height: 10),
                    _divider(),
                  ],
      
                  if ((convoi.typescarsconvois ?? []).isNotEmpty) ...[
                    _sectionTitle("Types de cars"),
                    ...convoi.typescarsconvois!.map((t) => Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        "- ${t.typecar} : ${t.nbrecars} car(s), ${t.nbreplaces} place(s)",
                        style: const TextStyle(fontSize: 14),
                      ),
                    )),
                    const SizedBox(height: 10),
                    _divider(),
                  ],
      
                  if ((convoi.carConvoi ?? []).isNotEmpty) ...[
                    _sectionTitle("Cars et Conducteurs"),
                    ...convoi.carConvoi!.map((car) => Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("- Matricule : ${car.matcar ?? "N/A"}", style: const TextStyle(fontSize: 14)),
                          Text("  Conducteur : ${car.nomconducteur ?? "N/A"}", style: const TextStyle(fontSize: 14)),
                          Text("  Sièges : ${car.nbresieges ?? 0}", style: const TextStyle(fontSize: 14)),
                        ],
                      ),
                    )),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _info(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 3, child: Text("$label :", style: const TextStyle(fontWeight: FontWeight.w600))),
          Expanded(flex: 5, child: Text(value ?? "Non renseigné")),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: GColor.bleu),
      ),
    );
  }

  Widget _divider() => const Divider(thickness: 1, height: 20);

  String _formatDate(DateTime? date) {
    if (date == null) return "Non renseignée";
    return DateFormat('dd/MM/yyyy').format(date);
  }
}
