import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdt_scan/component/api_service.dart';
import 'package:mdt_scan/page/Home/controller/home_controller.dart';

class PgHome extends StatefulWidget {
  const PgHome({super.key});

  @override
  State<PgHome> createState() => _PgHomeState();
}

class _PgHomeState extends State<PgHome> {
  final HomeController controller = Get.find();

@override
void initState() {
  super.initState();
  controller.ctrlScan.dispose(); 
  controller.ctrlScan =
      MobileScannerController(detectionSpeed: DetectionSpeed.noDuplicates); 
  controller.ctrlScan.start();
}
@override
void dispose() {
  controller.ctrlScan.dispose(); // seulement si non permanent
  super.dispose();
}


  @override
  Widget build(BuildContext context) {
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
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () => showApiSettingsDialog(context),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                AiBarcodeScanner(
                  controller: controller.ctrlScan,
                  onDetect: _handleScan,
                  borderRadius: 10,
                  borderWidth: 10,
                  cutOutSize: 300,
                  cutOutBottomOffset: 0,
                  hideGalleryIcon: true,
                  hideGalleryButton: true,
                  hideSheetDragHandler: true,
                  hideSheetTitle: true,
                  sheetChild: const SizedBox(),
                  setPortraitOrientation: false,
                  onDispose: () => print("Scanner de QR Code fermé."),
                ),
                Obx(() {
                  if (controller.isProcessing.value) {
                    return Container(
                      color: Colors.black.withOpacity(0.5),
                      child: const Center(),
                    );
                  }
                  return const SizedBox.shrink();
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleScan(BarcodeCapture capture) async {
    if (controller.isProcessing.value) return;

    final rawValue = capture.barcodes.first.rawValue ?? "";
    controller.isProcessing.value = true;

    try {
      await controller.ctrlScan.pause();

      if (rawValue.isEmpty || rawValue == 'null') {
        controller.qrResult.value = "QR Code invalide";
        return;
      }

      controller.scannedValue.value = rawValue;
      print('QR Detecté: $rawValue');

      if (!_isQRCodeFormatValide(rawValue)) {
        controller.qrResult.value = "Ticket invalide";
        return;
      }

      final elements =
          rawValue.contains("#") ? rawValue.split("#") : rawValue.split("@");

      if (elements.length < 2) {
        controller.qrResult.value = "QR Code incorrect";
        return;
      }

      final idTicket = elements[0];
      final reference = elements.length == 3 ? elements[2] : elements[1];

      await controller.fetchInfoTicket(
        context,
        id: idTicket,
        reference: reference,
      );
    } catch (e) {
      controller.qrResult.value = "Erreur lors du scan";
      print("Erreur: $e");
    } finally {
      controller.scannedValue.value = "";
      await Future.delayed(const Duration(milliseconds: 1500));
      controller.isProcessing.value = false;
      await controller.ctrlScan.start();
    }
  }

  bool _isQRCodeFormatValide(String value) {
    return value.contains("#") || value.contains("@");
  }
}
