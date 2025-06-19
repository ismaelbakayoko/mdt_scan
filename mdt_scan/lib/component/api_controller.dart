import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiController extends GetxController {
  static ApiController get instance => Get.find();
  var baseUrl = "http://192.168.115.133".obs;
  var port = "3080".obs;

  String get apiUrl {
    final uri = Uri.tryParse(baseUrl.value);

    final isHttps = baseUrl.value.startsWith('https');
    final hasPort = uri?.hasPort ?? false;
    final hasCustomPort = port.value.isNotEmpty;

    if (!isHttps && !hasPort && hasCustomPort) {
      return "${baseUrl.value}:${port.value}/api";
    } else {
      return "${baseUrl.value}/api";
    }
  }

  String get socketUrl {
    // final uri = Uri.parse(baseUrl.value);
    // final scheme = uri.scheme == "https" ? "ws" : "wss";
    var hostUrl = baseUrl.value.split("//").last;
    var ipPort = baseUrl.split("//").first;
    return "ws://$hostUrl${ipPort.contains("s") ? '' : ':${port.value}'}";
  }

  void updateBaseUrl(String newUrl) {
    baseUrl.value = newUrl.trim().replaceAll(RegExp(r'/api/?$'), '');
    _saveToPrefs();
  }

  void updatePort(String newPort) {
    port.value = newPort.trim();
    _saveToPrefs();
  }

  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("baseUrl", baseUrl.value);
    await prefs.setString("port", port.value);
  }

  Future<void> loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    baseUrl.value = prefs.getString("baseUrl") ?? baseUrl.value;
    port.value = prefs.getString("port") ?? port.value;
  }

  @override
  void onInit() {
    super.onInit();
    loadFromPrefs();
  }

  Rx<double> currentWidth = 0.0.obs;

  void updateSize(double newWidth) {
    currentWidth.value = newWidth;
    print("🛤️🛤️🛤️🛤️🛤️ Nouvelle taille : $newWidth 🚧🚧🚧🚧🚧");
  }
}
