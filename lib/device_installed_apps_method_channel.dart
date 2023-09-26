import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'app_info.dart';
import 'device_installed_apps_platform_interface.dart';

class MethodChannelDeviceInstalledApps extends DeviceInstalledAppsPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('device_installed_apps');

  @override
  Future<List<AppInfo>> getApps(
      String bundleIdPrefix,
        bool includeSystemApps,
        bool includeIcon,
        List<String> permissions,
        bool shouldHasAllPermissions,
      ) async {
    List<dynamic> apps = await methodChannel.invokeMethod('getApps',
      {
        'bundleIdPrefix': bundleIdPrefix,
        'includeSystemApps': includeSystemApps,
        'includeIcon': includeIcon,
        'permissions': permissions,
        'hasAllPermissions': shouldHasAllPermissions,
      },
    );
    List<AppInfo> appInfoList = apps.map((app) => AppInfo.create(app)).toList();
    appInfoList.sort((a, b) => a.name!.compareTo(b.name!));
    return appInfoList;
  }

  @override
  Future<List<AppInfo>> getSystemApps(
      String bundleIdPrefix,
      bool includeIcon,
      List<String> permissions,
      bool shouldHasAllPermissions,
      ) async {
    List<dynamic> apps = await methodChannel.invokeMethod('getSystemApps',
      {
        'bundleIdPrefix': bundleIdPrefix,
        'includeIcon': includeIcon,
        'permissions': permissions,
        'hasAllPermissions': shouldHasAllPermissions,
      },
    );
    List<AppInfo> appInfoList = apps.map((app) => AppInfo.create(app)).toList();
    appInfoList.sort((a, b) => a.name!.compareTo(b.name!));
    return appInfoList;
  }

  @override
  Future<List<String>> getAppsBundleIds(
        String bundleIdPrefix,
        bool includeSystemApps,
        List<String> permissions,
        bool shouldHasAllPermissions,
       ) async {
    List<String> apps = await methodChannel.invokeListMethod<String>('getAppsBundleIds',
      {
        'bundleIdPrefix': bundleIdPrefix,
        'includeSystemApps': includeSystemApps,
        'permissions': permissions,
        'hasAllPermissions': shouldHasAllPermissions,
      },
    ) ?? [];
    return apps;
  }

  @override
  Future<AppInfo> getAppInfo(String bundleId) async {
    var app = await methodChannel.invokeMethod('getAppInfo',{'bundleId': bundleId},);
    if (app == null) throw ('No App with package name = $bundleId');
    return AppInfo.create(app);
  }

  @override
  Future<bool?> launchApp(String bundleId) async {
    return methodChannel.invokeMethod('startApp', {'bundleId': bundleId},
    );
  }

  @override
  openAppSetting(String bundleId) {
    methodChannel.invokeMethod('openAppSetting',
      {'bundleId': bundleId},
    );
  }

  @override
  Future<bool?> isSystemApp(String bundleId) async {
    return methodChannel.invokeMethod('isSystemApp',{'bundleId': bundleId},);
  }
}
