import 'dart:convert';
import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mdt_scan/component/api_controller.dart';
import 'package:mdt_scan/component/error_function.dart';
import 'package:mdt_scan/model/bagage_model.dart';
import 'package:mdt_scan/model/colis_anuler_model.dart';
import 'package:mdt_scan/model/colis_model.dart';
import 'package:mdt_scan/model/convoi_model.dart';
import 'package:mdt_scan/model/ticket_model.dart';
import 'package:mdt_scan/page/Home/component/pg_bagage.dart';
import 'package:mdt_scan/page/Home/component/pg_colis.dart';
import 'package:mdt_scan/page/Home/component/pg_colisannuler.dart';
import 'package:mdt_scan/page/Home/component/pg_convoi.dart';
import 'package:mdt_scan/page/Home/component/pg_ticket.dart';
import 'package:toastification/toastification.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  final apiUrl = ApiController.instance.apiUrl;
  var torchState = false;
  var qrResult = "Aucun QR Code scanné".obs;
  var scannedValue = "".obs;
  late MobileScannerController ctrlScan = MobileScannerController(detectionSpeed: DetectionSpeed.noDuplicates);
  var isLoadEntretien = false.obs;
  var listColi = ColisModel().obs;
  var listBagage = BagagesModel().obs;
  var listConvoi = ConvoiModel().obs;
  var listTicket = TicketModel().obs;
  var colisAnnuler = ColisAnnuleModel().obs;
  var colisModifier = <ColisModifier>[].obs;
  var isProcessing = false.obs;

  var selecColis = false.obs;

  Future<void> onInit() async {
    super.onInit();
    ctrlScan =
        MobileScannerController(detectionSpeed: DetectionSpeed.noDuplicates);
  }

  @override
  void onClose() {
    ctrlScan.dispose();
    super.onClose();
  }

  String getSuccessMessage(String type) {
    switch (type) {
      case "TICKETS":
        return "Ticket scanné avec succès.";
      case "BAGAGES":
        return "Bagage identifié avec succès.";
      case "COLIS":
        return "Colis reconnu avec succès.";
      // ...
      default:
        return "Information récupérée.";
    }
  }

  Future<bool> fetchInfoTicket(
    BuildContext context, {
    required String id,
    required String reference,
  }) async {
    colisModifier.clear();
    final bodyData = {'id': id, 'reference': reference};
    print("🟡 Données envoyées : $bodyData");

    loadingCircular();
    try {
      final response = await http.post(
        Uri.parse("$apiUrl/controleTickets/recherche-generale-par-scan"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(bodyData),
      );

      final donnee = json.decode(response.body);
      print("🟢 Réponse : $donnee");

      if (donnee["success"] == true) {
        final data = donnee["resultat"];
        final type = donnee["type"];
        print("🧩 Type détecté : $type");

        // Traitement en fonction du type
        try {
          switch (type) {
            case "BAGAGES":
              listBagage.value = BagagesModel.fromJson(data);
              break;
            case "CONVOIS":
              listConvoi.value = ConvoiModel.fromJson(data);
              break;
            case "TICKETS":
              listTicket.value = TicketModel.fromJson(data);
              break;
            case "COLIS":
              listColi.value = ColisModel.fromJson(data);
              final rawColis = donnee["colisModifier"];
              if (rawColis != null && rawColis is List && rawColis.isNotEmpty) {
                colisModifier.value =
                    rawColis.map((e) => ColisModifier.fromJson(e)).toList();
              }

              break;
            case "COLIS_ANNULERS":
              colisAnnuler.value = ColisAnnuleModel.fromJson(data);
              break;
            case "COLIS_MODIFIES":
              // À implémenter si besoin
              break;
          }
        } catch (e) {
          print("⚠️ Erreur lors de la conversion JSON : $e");
          errorDialoge(errorText: "Erreur lors du traitement des données");
          return false;
        }

        // Navigation
        scannedValue.value = "";
        await ctrlScan.pause(); // Pause seulement après tout
        _navigateToPageByType(type);

        snackBar(
          title: "Succès",
          subtitle: getSuccessMessage(type),
          type: ToastificationType.success,
        );
        return true;
      } else {
        errorDialoge(errorText: donnee["message"] ?? "Erreur inconnue");
        return false;
      }
    } catch (e) {
      print("❌ Erreur API : $e");
      errorDialoge(errorText: "Erreur de connexion. Vérifiez votre Internet.");
      return false;
    } finally {
      closeLoadingCircular(); // Toujours fermer
    }
  }

  void _navigateToPageByType(String type) {
    switch (type) {
      case "TICKETS":
        print("direction‼️‼️");
        Get.offAll(() => PgTicket());
        break;
      case "BAGAGES":
        Get.offAll(() => const PgBagage());
        break;
      case "CONVOIS":
        Get.offAll(() => const PgConvoi());
        break;
      case "COLIS":
        Get.offAll(PgColis());
        break;
      case "COLIS_ANNULERS":
        Get.offAll(() => const PgColisAnnuler());
        break;
      case "COLIS_MODIFIES":
        Get.offAll(() => const PgColis());
        break;
      default:
        print("Aucune vue associée au type : $type");
    }
  }

  // statu de colis et bagages
  Future<bool> fetchStatuColisBagage(
    context, {
    required String? id,
    required String? code,
    required bool? statu,
    required String? table,
  }) async {
    var bodyData = {
      'id': id,
      'code': code,
      'statut': statu,
      'table': table,
    };
    print(bodyData);
    loadingCircular();
    try {
      final response = await http.post(
        Uri.parse("$apiUrl/controleTickets/bagage-colis-retrouver"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(bodyData),
      );
      var donnee = json.decode(response.body);
      print(donnee);

      if (donnee["success"] == true) {
        var data = donnee["resultat"];
        if (table == "BAGAGE") {
          listBagage.value.bagageIntrouvable = data;
        } else if (table == "COLIS") {
          listColi.value.colisintrouvable = data;
        }
        closeLoadingCircular();

        return true;
      } else {
        closeLoadingCircular();
        errorDialog("", errorText: donnee["message"]);
        if (table == "BAGAGE") {
          listBagage.value.bagageIntrouvable =
              !listBagage.value.bagageIntrouvable!;
          listBagage.refresh();
        } else if (table == "COLIS") {
          listColi.value.colisintrouvable = !listColi.value.colisintrouvable!;
          listColi.refresh();
        }
        return false;
      }
    } catch (e) {
      closeLoadingCircular();
      errorDialoge(errorText: "Connecter vous a internet");
      return false;
    }
  }
}
