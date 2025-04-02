import 'package:permission_handler/permission_handler.dart';

class PermissionHeandler {
  Future<void> handleNotificationPermission() async {
    final PermissionStatus status = await Permission.notification.request();

    if(status.isGranted){
      return;
    } else if(status.isDenied) {
      final PermissionStatus newStatus = await Permission.notification.request();
      if(newStatus.isGranted){
        return;
      }
    } else if(status.isPermanentlyDenied){
      openAppSettings();
      return;
    }
  }

}