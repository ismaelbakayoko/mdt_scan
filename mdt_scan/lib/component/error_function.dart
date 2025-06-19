import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

//Afficher un chargement
void loadingCircular() {
  Get.dialog(
    Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.white,
        color: Colors.cyan.shade700,
      ),
    ),
  );
}

//Afficher une notification temporairement
void snackBar({
  required String title,
  required String subtitle,
  required ToastificationType type,
}) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    toastification.show(
      type: type,
      style: ToastificationStyle.fillColored,
      title: Text(title,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
      description:
          Text(subtitle, style: const TextStyle(fontWeight: FontWeight.w500)),
      alignment: Alignment.topCenter,
      autoCloseDuration: const Duration(milliseconds: 2500),
      borderRadius: BorderRadius.circular(15.0),
      boxShadow: highModeShadow,
      showProgressBar: false,
      animationDuration: const Duration(milliseconds: 500),
      animationBuilder: (context, animation, alignment, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  });
}

//Fermer un chargement
Future<bool> closeLoadingCircular() async {
  if (Get.isDialogOpen == true) {
    Get.back();
    return true;
  } else {
    return false;
  }
}

//Afficher une boite de dialogue d'erreur
void errorDialog(donnee, {String? errorTitle, String? errorText}) {
  Get.defaultDialog(
    radius: 10,
    title: errorTitle ?? "Echec",
    titlePadding: const EdgeInsets.only(top: 15),
    contentPadding: const EdgeInsets.all(15),
    titleStyle: const TextStyle(
      color: Colors.deepOrange,
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),
    middleText:
        errorText ?? "Une erreur est survenu. Veuillez reéssayer plus tard",
    middleTextStyle: const TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
  );
}

void errorDialoge({required String errorText}) {
  Get.defaultDialog(
    title: "Erreur",
    middleText: errorText,
    textConfirm: "OK",
    confirmTextColor: Colors.white,
    buttonColor: Colors.red,
    onConfirm: () {
      Get.back(); // Ferme la boîte de dialogue
    },
    barrierDismissible: false, // Empêche la fermeture en cliquant en dehors
  );
}

// Initialiser le fichier JSON
// Future<File> initializeFile({required String fileName}) async {
//   final directory = await getApplicationCacheDirectory();
//   var localFile = File('${directory.path}/$fileName.json');

//   // Créer un fichier JSON vide s'il n'existe pas
//   if (!await localFile.exists()) {
//     await localFile.writeAsString("");
//     print("Fichier vide *$fileName* créé avec succès");
//   }

//   return localFile;
// }

// Sauvegarder les données dans le fichier JSON local
// Future<void> saveToLocal(
//     {required String fileNameJson, required List<dynamic> dataJson}) async {
//   final directory = await getApplicationCacheDirectory();
//   var localFile = File('${directory.path}/$fileNameJson.json');

//   try {
//     await localFile.writeAsString(json.encode(dataJson));
//     print("Fichier créé avec succès et enregistré dans ${localFile.path}");
//   } catch (e) {
//     print("Erreur lors de la sauvegarde des données : $e");
//   }
// }

// Suppirmer les fichier JSON local
// Future<void> deleteJsonFiles() async {
//   try {
//     // Obtenir le répertoire externe
//     final directory = await getApplicationCacheDirectory();
//     // if (directory == null) return;

//     // Lister les fichiers JSON dans ce répertoire
//     final files = directory
//         .listSync()
//         .where((file) => file is File && file.path.endsWith('.json'));

//     // Supprimer chaque fichier JSON
//     for (var file in files) {
//       await file.delete();
//     }
//     print("Fichiers JSON supprimés !");
//   } catch (e) {
//     print("Erreur lors de la suppression des fichiers : $e");
//   }
// }
