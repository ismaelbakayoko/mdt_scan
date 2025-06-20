import 'dart:convert';

import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mdt_scan/component/api_controller.dart';
import 'package:mdt_scan/component/error_function.dart';
import 'package:mdt_scan/model/bagage_model.dart';
import 'package:mdt_scan/model/colis_anuler_model.dart';
import 'package:mdt_scan/model/colis_model.dart';
import 'package:mdt_scan/model/colis_modifier_model.dart';
import 'package:mdt_scan/model/convoi_model.dart';
import 'package:mdt_scan/model/ticket_model.dart';
import 'package:mdt_scan/page/Home/component/pg_bagage.dart';
import 'package:mdt_scan/page/Home/component/pg_colis.dart';
import 'package:mdt_scan/page/Home/component/pg_colisannuler.dart';
import 'package:mdt_scan/page/Home/component/pg_colismodifier.dart';
import 'package:mdt_scan/page/Home/component/pg_convoi.dart';
import 'package:mdt_scan/page/Home/component/pg_ticket.dart';
import 'package:toastification/toastification.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  final apiUrl = ApiController.instance.apiUrl;
  var torchState = false;
  var qrResult = "Aucun QR Code scanné".obs;
  var scannedValue = "".obs;
  final MobileScannerController ctrlScan =
      MobileScannerController(detectionSpeed: DetectionSpeed.noDuplicates);
  var isLoadEntretien = false.obs;
  var listColi = ColisModel().obs;
  var listBagage = BagagesModel().obs;
  var listConvoi = ConvoiModel().obs;
  var listTicket = TicketModel().obs;
  var colisAnnuler = ColisAnnuleModel().obs;
  var colisModifier = ColisModifieModel().obs;

  Future<void> onInit() async {
    super.onInit();
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
    context, {
    required String id,
    required String reference,
  }) async {
    print("❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌");
    var bodyData = {
      'id': id,
      'reference': reference,
    };
    print(bodyData);
    loadingCircular();
    try {
      final response = await http.post(
        Uri.parse("$apiUrl/controleTickets/recherche-generale-par-scan"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(bodyData),
      );
      var donnee = json.decode(response.body);
      print(donnee);

      if (donnee["success"] == true) {
        var data = donnee["resultat"];
        closeLoadingCircular();

        var type = donnee["type"];
        print(type);
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
            break;
          case "COLIS_ANNULERS":
            colisAnnuler.value = ColisAnnuleModel.fromJson(data);
            break;
          case "COLIS_MODIFIES":
            colisModifier.value = ColisModifieModel.fromJson(data);
            break;
        }
        scannedValue.value = "";
        _navigateToPageByType(type);

        snackBar(
          title: "Succès",
          subtitle: getSuccessMessage(type),
          type: ToastificationType.success,
        );
        return true;
      } else {
        closeLoadingCircular();
        errorDialog("", errorText: donnee["message"]);
        return false;
      }
    } catch (e) {
      closeLoadingCircular();
      errorDialog("Erreur", errorText: "Une erreur s’est produite : $e");
      return false;
    }
  }

  void _navigateToPageByType(String type) {
    switch (type) {
      case "TICKETS":
        print("direction‼️‼️");
        Get.to(() => PgTicket());
        break;
      case "BAGAGES":
        Get.to(() => const PgBagage());
        break;
      case "CONVOIS":
        Get.to(() => const PgConvoi());
        break;
      case "COLIS":
        Get.to(() => const PgColis());
        break;
      case "COLIS_ANNULERS":
        Get.to(() => const PgColisAnnuler());
        break;
      case "COLIS_MODIFIES":
        Get.to(() => const PgColisModifier());
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
      errorDialog("Erreur", errorText: "Une erreur s’est produite : $e");
      return false;
    }
  }
}
