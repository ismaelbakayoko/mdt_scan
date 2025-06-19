import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdt_scan/page/Home/controller/home_controller.dart';

class PgHome extends StatelessWidget {
  PgHome({super.key});
  final HomeController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text(
            "Verification ticket",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
           
            
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // const Padding(
                    //   padding: const EdgeInsets.only(top: 10, bottom: 15),
                    //   child: Text(
                    //     "Scanner le code QR du reçu",
                    //     textAlign: TextAlign.center,
                    //     style: TextStyle(
                    //         fontWeight: FontWeight.w600, fontSize: 16),
                    //   ),
                    // ),
                    Expanded(
                      child: AiBarcodeScanner(
                        onDetect: (BarcodeCapture barcodeCapture) async {
                          print(
                              '${controller.scannedValue.value}‼️‼️‼️‼️‼️👌👌👌👌👌');
                          controller.scannedValue.value =
                              barcodeCapture.barcodes.first.rawValue.toString();
                          // if ((controller.scannedValue.value.isNotEmpty ||
                          //     controller.scannedValue.value != 'null')) {
                          if (controller.scannedValue.value.contains("#") ||
                              controller.scannedValue.value.contains("@")) {
                            var codeQr = controller.scannedValue.value
                                        .split("#")
                                        .length !=
                                    1
                                ? controller.scannedValue.value.split("#")
                                : controller.scannedValue.value.split("@");

                            if (codeQr.length != 3) {
                              var idTicket = codeQr[0];
                              var reference = codeQr[1];
                              controller.fetchInfoTicket(context,
                                  id: idTicket, reference: reference);

                              controller.qrResult.value = "Ticket invalide";
                              await controller.ctrlScan.pause();
                              Future.delayed(Duration(milliseconds: 1500))
                                  .then((v) async {
                                await controller.ctrlScan.start();
                              });
                            } else {
                              var idTicket = codeQr[0];
                              var refVoyageTicket = codeQr[2];

                              controller.fetchInfoTicket(context,
                                  id: idTicket, reference: refVoyageTicket);
                              barcodeCapture.barcodes.first.rawValue!.isEmpty;
                            }
                          } else {
                            // errorDialog(
                            //   errorTitle: "Ticket non trouvé !",
                            //   errorText: "Ce ticket est invalide",
                            // );
                            controller.qrResult.value = "Ticket invalide";
                            await controller.ctrlScan.pause();
                            Future.delayed(Duration(milliseconds: 1500))
                                .then((v) async {
                              await controller.ctrlScan.start();
                            });
                          }
                          // } else {
                          //   controller.qrResult.value = "Aucun QR Code scanné";
                          // }
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
                        // appBarBuilder: (context, controller) {
                        //   return AppBar(
                        //     backgroundColor: Colors.amber.shade50,
                        //     toolbarHeight: 1,
                        //     automaticallyImplyLeading: false,
                        //   );
                        // },
                        controller: controller.ctrlScan,
                        setPortraitOrientation: false,
                        sheetChild: SizedBox(),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 15),
                    //   child: Text(
                    //     controller.qrResult.value,
                    //     textAlign: TextAlign.center,
                    //     style: TextStyle(
                    //         fontSize: 16, fontWeight: FontWeight.w600),
                    //   ),
                    // ),
                  ],
                ),
              )
         
          ],
        ));
  }
}
