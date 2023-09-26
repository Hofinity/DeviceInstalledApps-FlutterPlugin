import 'package:flutter_test/flutter_test.dart';
import 'package:device_installed_apps/device_installed_apps.dart';
import 'package:device_installed_apps/device_installed_apps_platform_interface.dart';
import 'package:device_installed_apps/device_installed_apps_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDeviceInstalledAppsPlatform
    with MockPlatformInterfaceMixin
    implements DeviceInstalledAppsPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final DeviceInstalledAppsPlatform initialPlatform = DeviceInstalledAppsPlatform.instance;

  test('$MethodChannelDeviceInstalledApps is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelDeviceInstalledApps>());
  });

  test('getPlatformVersion', () async {
    DeviceInstalledApps deviceInstalledAppsPlugin = DeviceInstalledApps();
    MockDeviceInstalledAppsPlatform fakePlatform = MockDeviceInstalledAppsPlatform();
    DeviceInstalledAppsPlatform.instance = fakePlatform;

    expect(await deviceInstalledAppsPlugin.getPlatformVersion(), '42');
  });
}
