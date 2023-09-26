import 'dart:typed_data';

class AppInfo {
  String? name;
  String? bundleId;
  Uint8List? icon;
  String? versionName;
  int? versionCode;

  AppInfo(this.name, this.bundleId, this.icon, this.versionName, this.versionCode,);

  factory AppInfo.create(dynamic data) {
    return AppInfo(
      data["name"],
      data["bundleId"],
      data["icon"],
      data["versionName"],
      data["versionCode"],
    );
  }
}
