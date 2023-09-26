package com.hofinity.device_installed_apps

import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager
import android.os.Build.VERSION.SDK_INT
import android.os.Build.VERSION_CODES.P
import android.util.Log
import java.util.*

object AppUtil {

    internal fun filterApps(apps: List<ApplicationInfo>,
                            bundleIdPrefix: String,
                            includeSystemApps: Boolean,
                            onlySystemApps: Boolean,
                            permissions:List<String>,
                            shouldHasAllPermissions: Boolean): List<ApplicationInfo> {
        var innerApps = apps
        if(onlySystemApps) {
            innerApps = innerApps.filter {
                app -> isSystemApp(app.packageName)
            }
        } else {
            if (!includeSystemApps) innerApps = innerApps.filter {
                    app -> !isSystemApp(app.packageName)
            }
        }

        if (bundleIdPrefix.isNotEmpty()) innerApps = innerApps.filter {
                app -> app.packageName.startsWith(bundleIdPrefix.lowercase(Locale.ENGLISH))
        }

        if(permissions.isNotEmpty()) innerApps = innerApps.filter {
                app -> hasPermissions(app.packageName, permissions, shouldHasAllPermissions)
        }
        return innerApps
    }

    private fun hasPermissions(bundleId: String,
                                permissions:List<String>,
                                shouldHasAllPermissions: Boolean): Boolean {
        var shouldInclude = false
        try {
            val packageInfo = DeviceInstalledAppsPlugin.getContext()!!.packageManager.getPackageInfo(bundleId, PackageManager.GET_PERMISSIONS)
            val requestedPermissions = packageInfo.requestedPermissions
            if (requestedPermissions != null) {
                if(shouldHasAllPermissions) {
                    var count = 0
                    for(i in requestedPermissions.indices) {
                        for(permission in permissions) {
                            if ((requestedPermissions[i] == permission)) {
                                count++
                                break
                            }
                        }
                    }
                    shouldInclude = (count == permissions.size)
                } else {
                    var count = 0
                    for(i in requestedPermissions.indices) {
                        for(permission in permissions) {
                            if ((requestedPermissions[i] == permission)) {
                                count++
                                shouldInclude = true
                                break
                            }
                            if(count > 0) break
                        }
                    }
                }
            }
        } catch (e: PackageManager.NameNotFoundException) {
            Log.e(DeviceInstalledAppsPlugin.TAG, "Error checking permissions ~~~> ${e.localizedMessage}")
            shouldInclude = false
        }
        return shouldInclude
    }

    @Suppress("DEPRECATION")
    fun appToHashMap(app: ApplicationInfo,includeIcon: Boolean): HashMap<String, Any?> {
        val pm = DeviceInstalledAppsPlugin.getContext()?.packageManager
        val packageInfo = pm?.getPackageInfo(app.packageName, 0)
        val map = HashMap<String, Any?>()
        map["name"] = pm?.getApplicationLabel(app)
        map["bundleId"] = app.packageName
        map["versionName"] = packageInfo!!.versionName
        map["versionCode"] = if (SDK_INT > P) packageInfo.longVersionCode else packageInfo.versionCode.toLong()
        map["icon"] = if (includeIcon) DrawableUtils.drawableToByteArray(app.loadIcon(pm)) else ByteArray(0)
        return map
    }

    internal fun isSystemApp(bundleId: String): Boolean {
        if (bundleId.isBlank()) {
            Log.e(DeviceInstalledAppsPlugin.TAG, "Error Checking System App ~~~> BundleId is empty!!!")
            return false
        }
//        try {
//            val mask = ApplicationInfo.FLAG_SYSTEM or ApplicationInfo.FLAG_UPDATED_SYSTEM_APP
//            return DeviceInstalledAppsPlugin.getContext()?.packageManager?.getLaunchIntentForPackage(bundleId)?.flags!! and mask != 0
//        } catch (e: Exception) {
//            Log.e(DeviceInstalledAppsPlugin.TAG, "Error Checking System App ~~~> BundleId not found")
//            return false
//        }
        try {
            val apps = DeviceInstalledAppsPlugin.getContext()!!.packageManager.getInstalledApplications(0)
            var count = 0
            for(i in apps.indices) {
                if ((apps[i].packageName == bundleId)) {
                    count++
                    break
                }
            }
            if(count > 0) return DeviceInstalledAppsPlugin.getContext()?.packageManager?.getLaunchIntentForPackage(bundleId) == null
            else Log.e(DeviceInstalledAppsPlugin.TAG, "Error Checking System App ~~~> BundleId not found")
        } catch (e: PackageManager.NameNotFoundException) {
            Log.e(DeviceInstalledAppsPlugin.TAG, "Error checking permissions ~~~> ${e.localizedMessage}")
        }
        return false
    }

}