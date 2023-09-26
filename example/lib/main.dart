import 'package:flutter/material.dart';
import 'dart:async';

import 'package:device_installed_apps/device_installed_apps.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {

    DeviceInstalledApps.getApps(includeSystemApps: true, permissions: ['android.permission.NFC','android.permission.ACCESS_FINE_LOCATION'],shouldHasAllPermissions: false,).then((value) => {
      print("(DeviceInstalledApps) 1- ${value.length}"),
    for (var i = 0; i < value.length; i++) {
      print("(DeviceInstalledApps) 1.$i- ${value[i].bundleId}")
    }
    });

    DeviceInstalledApps.getSystemApps().then((value) => {
      print("(DeviceInstalledApps) 2- ${value.length}"),
      for (var i = 0; i < value.length; i++) {
        print("(DeviceInstalledApps) 2.$i- ${value[i].bundleId}")
      }
    });

    DeviceInstalledApps.getAppsBundleIds().then((value) => {
      print("(DeviceInstalledApps) 3- ${value.length}")
    });

    DeviceInstalledApps.getAppInfo('com.hofinity').then((value) => {
      print("(DeviceInstalledApps) 4- ${value.name}")
    });

    DeviceInstalledApps.isSystemApp('com.hofinity').then((value) => {
      print("(DeviceInstalledApps) 5- $value")
    });

    DeviceInstalledApps.launchApp('com.hofinity').then((value) => {
      print("(DeviceInstalledApps) 6- $value")
    });

    // DeviceInstalledApps.openAppSetting('com.hofinity');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin Example App'),
        ),
        body: const Center(
          child: Text('DeviceInstalledApps'),
        ),
      ),
    );

  }
}
