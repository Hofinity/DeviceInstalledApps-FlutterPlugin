import 'app_info.dart';
import 'device_installed_apps_platform_interface.dart';

class DeviceInstalledApps {
  /// Device installed apps.
  ///
  /// (`optional params`):
  ///
  /// String bundleIdPrefix ~~~> filters apps that start with the given prefix.
  ///
  /// bool includeSystemApps ~~~> if `true` returns list with system apps /
  /// if `false` ignores system apps in list.
  ///
  /// bool includeIcon ~~~> if `true` returns app's icon/ if `false` returns null for app's icon.
  ///
  /// List<String> permissions ~~~> filters apps with the given permissions.
  ///
  /// bool shouldHasAllPermissions ~~~> if `true` returned apps should have all the given permissions /
  /// if `false` returned apps should have at least one of the permissions.
  ///
  /// ..........................................................................
  static Future<List<AppInfo>> getApps({
    String bundleIdPrefix = '',
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

  /// Device system apps.
  ///
  /// (`optional params`):
  ///
  /// String bundleIdPrefix ~~~> filters apps that start with the given prefix.
  ///
  /// bool includeIcon ~~~> if `true` returns app's icon/ if `false` returns null for app's icon.
  ///
  /// List<String> permissions ~~~> filters apps with the given permissions.
  ///
  /// bool shouldHasAllPermissions ~~~> if `true` returned apps should have all the given permissions /
  /// if `false` returned apps should have at least one of the permissions.
  ///
  /// ..........................................................................
  static Future<List<AppInfo>> getSystemApps({
    String bundleIdPrefix = '',
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

  /// Device installed apps bundleIds.
  ///
  /// (`optional params`):
  ///
  /// String bundleIdPrefix ~~~> filters apps that start with the given prefix.
  ///
  /// bool includeSystemApps ~~~> if `true` returns list with system apps /
  /// if `false` ignores system apps in list.
  ///
  /// bool includeIcon ~~~> if `true` returns app's icon/ if `false` returns null for app's icon.
  ///
  /// List<String> permissions ~~~> filters apps with the given permissions.
  ///
  /// bool shouldHasAllPermissions ~~~> if `true` returned apps should have all the given permissions /
  /// if `false` returned apps should have at least one of the permissions.
  ///
  /// ..........................................................................
  static Future<List<String>> getAppsBundleIds({
    String bundleIdPrefix = '',
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

  ///  Get an app info.
  ///
  /// (`params`):
  ///
  /// String bundleId ~~~> Bundle Id of the target app.
  ///
  /// ..........................................................................
  static Future<AppInfo> getAppInfo(String bundleId) {
    return DeviceInstalledAppsPlatform.instance.getAppInfo(bundleId);
  }

  ///  Launch an app.
  ///
  /// (`params`):
  ///
  /// String bundleId ~~~> Bundle Id of the target app.
  ///
  /// ..........................................................................
  static Future<bool?> launchApp(String bundleId) {
    return DeviceInstalledAppsPlatform.instance.launchApp(bundleId);
  }

  /// Open app os settings.
  ///
  /// (`params`):
  ///
  /// String bundleId ~~~> Bundle Id of the target app.
  ///
  /// ..........................................................................
  static openAppSetting(String bundleId) {
    return DeviceInstalledAppsPlatform.instance.openAppSetting(bundleId);
  }

  /// Check if an app is system app.
  ///
  /// (`params`):
  ///
  /// String bundleId ~~~> Bundle Id of the target app.
  ///
  /// ..........................................................................
  static Future<bool?> isSystemApp(String bundleId) {
    return DeviceInstalledAppsPlatform.instance.isSystemApp(bundleId);
  }
}
