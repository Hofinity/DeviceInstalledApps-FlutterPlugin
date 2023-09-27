import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'app_info.dart';
import 'device_installed_apps_method_channel.dart';

abstract class DeviceInstalledAppsPlatform extends PlatformInterface {
  DeviceInstalledAppsPlatform() : super(token: _token);

  static final Object _token = Object();

  static DeviceInstalledAppsPlatform _instance =
      MethodChannelDeviceInstalledApps();

  static DeviceInstalledAppsPlatform get instance => _instance;

  static set instance(DeviceInstalledAppsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<List<AppInfo>> getApps(
    String bundleIdPrefix,
    bool includeSystemApps,
    bool includeIcon,
    List<String> permissions,
    bool shouldHasAllPermissions,
  ) async {
    throw UnimplementedError('getInstalledApps() has not been implemented.');
  }

  Future<List<AppInfo>> getSystemApps(
    String bundleIdPrefix,
    bool includeIcon,
    List<String> permissions,
    bool shouldHasAllPermissions,
  ) async {
    throw UnimplementedError('getInstalledApps() has not been implemented.');
  }

  Future<List<String>> getAppsBundleIds(
    String bundleIdPrefix,
    bool includeSystemApps,
    List<String> permissions,
    bool shouldHasAllPermissions,
  ) {
    throw UnimplementedError('getAppsBundleIds() has not been implemented.');
  }

  Future<AppInfo> getAppInfo(String bundleId) {
    throw UnimplementedError('getAppInfo() has not been implemented.');
  }

  Future<bool?> launchApp(String bundleId) {
    throw UnimplementedError('launchApp() has not been implemented.');
  }

  openAppSetting(String bundleId) {
    throw UnimplementedError('openSettings() has not been implemented.');
  }

  Future<bool?> isSystemApp(String bundleId) {
    throw UnimplementedError('isSystemApp() has not been implemented.');
  }
}
