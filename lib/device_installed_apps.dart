
import 'app_info.dart';
import 'device_installed_apps_platform_interface.dart';

class DeviceInstalledApps {

  static Future<List<AppInfo>> getApps(
      { String bundleIdPrefix = '',
        bool includeSystemApps = false,
        bool includeIcon = false,
        List<String> permissions = const [],
        bool shouldHasAllPermissions = false,
      }) {
    return DeviceInstalledAppsPlatform.instance.getApps(
        bundleIdPrefix = bundleIdPrefix,
        includeSystemApps = includeSystemApps,
        includeIcon = includeIcon,
        permissions = permissions,
        shouldHasAllPermissions = shouldHasAllPermissions);
  }

  static Future<List<AppInfo>> getSystemApps(
      { String bundleIdPrefix = '',
        bool includeIcon = false,
        List<String> permissions = const [],
        bool shouldHasAllPermissions = false,
      }) {
    return DeviceInstalledAppsPlatform.instance.getSystemApps(
        bundleIdPrefix = bundleIdPrefix,
        includeIcon = includeIcon,
        permissions = permissions,
        shouldHasAllPermissions = shouldHasAllPermissions);
  }

  static Future<List<String>> getAppsBundleIds(
      { String bundleIdPrefix = '',
        bool includeSystemApps = false,
        List<String> permissions = const [],
        bool shouldHasAllPermissions = false,
      }) {
    return DeviceInstalledAppsPlatform.instance.getAppsBundleIds(
        bundleIdPrefix = bundleIdPrefix,
        includeSystemApps = includeSystemApps,
        permissions = permissions,
        shouldHasAllPermissions = shouldHasAllPermissions);
  }

  static Future<AppInfo> getAppInfo(String bundleId) {
    return DeviceInstalledAppsPlatform.instance.getAppInfo(bundleId);
  }

  static Future<bool?> launchApp(String bundleId) {
    return DeviceInstalledAppsPlatform.instance.launchApp(bundleId);
  }

  static openAppSetting(String bundleId) {
    return DeviceInstalledAppsPlatform.instance.openAppSetting(bundleId);
  }

  static Future<bool?> isSystemApp(String bundleId) {
    return DeviceInstalledAppsPlatform.instance.isSystemApp(bundleId);
  }
}
