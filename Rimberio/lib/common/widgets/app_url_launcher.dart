import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart' hide Trans;
import 'package:url_launcher/url_launcher.dart';

class AppUrlLauncher {
  static Future<void> launchStaticUrl(String value, String type) async {
    Uri url;
    if (type == 'PHONE'.tr()) {
      url = Uri.parse('tel:$value');
    } else {
      url = Uri.parse(value);
    }

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      Get.snackbar('Error', 'Could not launch $value');
    }
  }
}
