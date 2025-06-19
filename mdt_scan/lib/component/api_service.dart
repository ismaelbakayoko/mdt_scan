import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdt_scan/component/api_controller.dart';

void showApiSettingsDialog(BuildContext context) {
  final ApiController apiController = Get.find<ApiController>();

  final urlController = TextEditingController(text: apiController.baseUrl.value);
  final portController = TextEditingController(text: apiController.port.value);

  showDialog(
    context: context,
    builder: (_) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 400, 
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "🔧 Configuration de l'API",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: urlController,
                decoration: InputDecoration(
                  labelText: "URL de base",
                  hintText: "ex: http://192.168.1.100",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: Icon(Icons.link),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: portController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Port (optionnel)",
                  hintText: "ex: 3080",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: Icon(Icons.dns),
                ),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.grey[700],
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Text("Annuler"),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      apiController.updateBaseUrl(urlController.text);
                      apiController.updatePort(portController.text);
                      Navigator.pop(context);

                      // Optionnel : message de confirmation
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Configuration API mise à jour."),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    icon: Icon(Icons.save),
                    label: Text("Enregistrer"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}
