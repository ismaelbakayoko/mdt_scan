import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mdt_scan/page/Home/controller/home_controller.dart';

class PgTicket extends StatelessWidget {
  PgTicket({super.key});
  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final ticket = controller.listTicket.value;

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
            "Détails du Ticket",
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
                _sectionTitle("Voyage"),
                _infoRow("Réf voyage", ticket.refVoyage),
                _infoRow("Matricule car", ticket.matCar),
                const SizedBox(height: 5),
                _divider(),
                _sectionTitle("Trajet"),
                _infoRow("Gare de départ", ticket.nomGare),
                _infoRow("Destination", ticket.destination),
                const SizedBox(height: 5),
                _divider(),
                _sectionTitle("Siège"),
                _infoRow("Numéro siège", ticket.numSiege),
                _infoRow("Siège remplacé", ticket.numSiegeRemplace),
                const SizedBox(height: 10),
                _divider(),
                _sectionTitle("Client"),
                _infoRow("Code client", ticket.codeClient),
                _infoRow("Contact client", ticket.contactClient),
                const SizedBox(height: 5),
                _divider(),
                _sectionTitle("Informations Ticket"),
                _infoRow("Type ticket", ticket.typeTicket),
                _infoRow("Prix", "${ticket.prixTicket ?? 0} FCFA"),
                _infoRow("Date", formatDate(ticket.dateTicket)),
                _infoRow("Ticket utilisé", _boolToStr(ticket.ticketUtiliser)),
                _infoRow("Paiement ligne", _boolToStr(ticket.paiementEnLigne)),
                const SizedBox(height: 5),
                _divider(),
                _sectionTitle("Agent"),
                _infoRow("Guichetière", ticket.nomGuichetiere),
                _infoRow("Mat guichetière", ticket.matGuichetiere),
                const SizedBox(height: 5),
                _divider(),
                _sectionTitle("Options"),
                _infoRow("Est remplacé", _boolToStr(ticket.isRemplaced)),
                _infoRow("Siège vacant", _boolToStr(ticket.siegeVacant)),
                _infoRow("Absent", _boolToStr(ticket.oldAbsent)),
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
      padding: const EdgeInsets.only(bottom: 5),
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
