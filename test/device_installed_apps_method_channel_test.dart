import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:device_installed_apps/device_installed_apps_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelDeviceInstalledApps platform = MethodChannelDeviceInstalledApps();
  const MethodChannel channel = MethodChannel('device_installed_apps');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
