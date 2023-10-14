# device_installed_apps

[Plugin](https://pub.dev/packages/device_installed_apps) for Flutter with methods related to device installed apps.

| Supported platform  |
| :-----:             |
| Android             |
## Getting Started

- [Installation Guide](https://pub.dev/packages/device_installed_apps#-installing-tab-)

> [!WARNING]  
> For Android 11 or later, you need to add ```<uses-permission android:name="android.permission.QUERY_ALL_PACKAGES" />``` permission in your **AndroidManifest.xml** file to Query **all** packages but this is restricted for Google Play, see more at [here](https://support.google.com/googleplay/android-developer/answer/10158779). If you don't add it, you can still use package but you don't get some system apps.
## Usage

#### Device installed apps
``` dart
List<AppInfo> apps = await DeviceDeviceInstalledApps.getApps(
							String bundleIdPrefix,
							bool includeSystemApps, 
							bool includeIcon,
		      				List<String> permissions,
      						bool shouldHasAllPermissions);
```
###### Example

``` dart
var permissions = ['android.permission.NFC','android.permission.ACCESS_FINE_LOCATION'];

List<AppInfo> apps = await DeviceDeviceInstalledApps.getApps(includeSystemApps: true, permissions: permissions, bundleIdPrefix: 'com.hofinity', shouldHasAllPermissions: false);
```
---------


#### Device system apps
``` dart
List<AppInfo> apps = await DeviceDeviceInstalledApps.getSystemApps(
							String bundleIdPrefix,
							bool includeIcon,
		      				List<String> permissions,
      						bool shouldHasAllPermissions);
```
###### Example

``` dart
var permissions = ['android.permission.NFC','android.permission.ACCESS_FINE_LOCATION'];
List<AppInfo> apps = await DeviceDeviceInstalledApps.getSystemApps(permissions: permissions, bundleIdPrefix: 'com.hofinity', shouldHasAllPermissions: false);
```
---------

#### Device installed apps bundleIds
``` dart
List<String> apps = await DeviceDeviceInstalledApps.getAppsBundleIds(
							String bundleIdPrefix,
							bool includeSystemApps, 
							bool includeIcon,
		      				List<String> permissions,
      						bool shouldHasAllPermissions);
```
###### Example

``` dart
var permissions = ['android.permission.NFC','android.permission.ACCESS_FINE_LOCATION'];
List<String> apps = await DeviceDeviceInstalledApps.getAppsBundleIds(includeSystemApps: true, permissions: permissions, bundleIdPrefix: 'com.hofinity', shouldHasAllPermissions: false);
```
---------

#### Get an app info
``` dart
AppInfo app = await DeviceInstalledApps.getAppInfo(String bundleId);
```

#### Launch an app
``` dart
DeviceInstalledApps.launchApp(String bundleId);
```
#### Open app os settings
``` dart
DeviceInstalledApps.openSettings(String bundleId);
```
#### Check if an app is system app
``` dart
bool isSystemApp = await DeviceInstalledApps.isSystemApp(String bundleId);
```



