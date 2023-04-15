import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandler {
 static Future<bool> requestPermission() async {
    late final Map<Permission, PermissionStatus> statuses;
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    if (androidInfo.version.sdkInt <= 32) {
      statuses = await [
        Permission.storage,
      ].request();
    } else {
      statuses = await [
        Permission.photos,
        Permission.videos,
        Permission.audio,
      ].request();
    }

    bool ispass = true;
    statuses.forEach((key, value) {
      if (value.isDenied) {
        ispass = false;
      } else if (value.isPermanentlyDenied) {
        ispass = false;
        openAppSettings();
      }
    });
    return ispass;
  }
}