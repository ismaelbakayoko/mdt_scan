import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdt_scan/component/api_controller.dart';
import 'package:mdt_scan/page/Home/controller/home_controller.dart';
import 'package:mdt_scan/page/Home/page/Pg_home.dart';
import 'package:toastification/toastification.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  return DateFormat.yMd('fr_FR').format(date);
}

String formatHeure(DateTime heure) {
  return DateFormat.Hm().format(heure);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final apiController = Get.put(ApiController());
  await apiController.loadFromPrefs();
  await initializeDateFormatting();

  Get.put(HomeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('fr_FR', null);
    return ToastificationWrapper(
      child: GetMaterialApp(
        title: 'Mdt Scan',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // localizationsDelegates: const [
        //   GlobalMaterialLocalizations.delegate,
        //   GlobalWidgetsLocalizations.delegate,
        //   GlobalCupertinoLocalizations.delegate,
        // ],
        debugShowCheckedModeBanner: false,
        // supportedLocales: const [
        //   Locale('en', 'US'),
        //   Locale('fr', 'FR'), // Ajoute la langue que tu veux utiliser
        // ],
        home: PgHome(),
      ),
    );
  }
}
