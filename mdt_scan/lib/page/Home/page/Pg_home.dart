import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdt_scan/component/api_service.dart';
import 'package:mdt_scan/page/Home/controller/home_controller.dart';

class PgHome extends StatefulWidget {
  PgHome({super.key});

  @override
  State<PgHome> createState() => _PgHomeState();
}

class _PgHomeState extends State<PgHome> {
  final HomeController controller = Get.find();

  // @override
  // void initState() {
  //   super.initState();

  // }

  @override
  Widget build(BuildContext context) {
    controller.ctrlScan.start();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text(
            "Scanner le reçu",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                icon: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                onPressed: () {
                  showApiSettingsDialog(context);
                })
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: AiBarcodeScanner(
                      onDetect: (BarcodeCapture barcodeCapture) async {
                        // Lecture brute du QR
                        final rawValue = barcodeCapture.barcodes.first.rawValue
                                ?.toString() ??
                            "";

                        print('$rawValue ‼️‼️‼️👌👌👌');

                        // Sauvegarde de la valeur brute
                        controller.scannedValue.value = rawValue;

                        // Si vide ou null, QR invalide
                        if (rawValue.isEmpty || rawValue == 'null') {
                          controller.qrResult.value = "QR Code invalide";
                          await controller.ctrlScan.pause();
                          controller.scannedValue.value =
                              ""; // Réinitialisation
                          Future.delayed(Duration(milliseconds: 1500))
                              .then((v) async {
                            await controller.ctrlScan.start();
                          });
                          return;
                        }

                        // Vérifie s'il y a un séparateur (# ou @)
                        if (rawValue.contains("#") || rawValue.contains("@")) {
                          var codeQr = rawValue.contains("#")
                              ? rawValue.split("#")
                              : rawValue.split("@");

                          if (codeQr.length != 3) {
                            // Cas de ticket à 2 éléments
                            var idTicket = codeQr[0];
                            var reference = codeQr[1];

                            controller.fetchInfoTicket(
                              context,
                              id: idTicket,
                              reference: reference,
                            );

                            controller.qrResult.value =
                                "Ticket invalide"; // Valeur temporaire ?
                          } else {
                            // Cas de ticket à 3 éléments
                            var idTicket = codeQr[0];
                            var refVoyageTicket = codeQr[2];

                            controller.fetchInfoTicket(
                              context,
                              id: idTicket,
                              reference: refVoyageTicket,
                            );
                          }

                          // Pause + redémarrage du scanner
                          await controller.ctrlScan.pause();
                          controller.scannedValue.value = "";
                          Future.delayed(Duration(milliseconds: 1500))
                              .then((v) async {
                            await controller.ctrlScan.start();
                          });
                        } else {
                          // Format incorrect
                          controller.qrResult.value = "Ticket invalide";
                          await controller.ctrlScan.pause();
                          controller.scannedValue.value =
                              ""; // Important : réinitialiser
                          Future.delayed(Duration(milliseconds: 1500))
                              .then((v) async {
                            await controller.ctrlScan.start();
                          });
                        }
                      },
                      borderRadius: 10,
                      borderWidth: 10,
                      cutOutSize: 300,
                      cutOutBottomOffset: 0,
                      hideGalleryIcon: true,
                      hideGalleryButton: true,
                      hideSheetDragHandler: true,
                      hideSheetTitle: true,
                      onDispose: () {
                        print("Scanner de QR Code fermé.");
                      },
                      controller: controller.ctrlScan,
                      setPortraitOrientation: false,
                      sheetChild: SizedBox(),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
