package com.hofinity.device_installed_apps

import android.annotation.SuppressLint
import android.content.Context
import android.content.Intent
import android.content.Intent.FLAG_ACTIVITY_NEW_TASK
import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager
import android.net.Uri
import android.provider.Settings.ACTION_APPLICATION_DETAILS_SETTINGS
import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.util.ArrayList
import java.util.Locale.ENGLISH

/** DeviceInstalledAppsPlugin */
@SuppressLint("StaticFieldLeak")
class DeviceInstalledAppsPlugin(): FlutterPlugin, MethodCallHandler, ActivityAware {

  companion object {
    var TAG =  DeviceInstalledAppsPlugin::class.java.name
    private var context: Context? = null

    fun getContext(): Context? = context

  }

  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "device_installed_apps")
    channel.setMethodCallHandler(this)
  }

  override fun onAttachedToActivity(activityPluginBinding: ActivityPluginBinding) {
    context = activityPluginBinding.getActivity()
  }

  override fun onDetachedFromActivityForConfigChanges() {}

  override fun onReattachedToActivityForConfigChanges(activityPluginBinding: ActivityPluginBinding) {
    context = activityPluginBinding.getActivity()
  }

  override fun onDetachedFromActivity() {}

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (context == null) {
      result.error("500", "(DeviceInstalledApps) ~~~> Context is null!!!", null)
      return
    }
    when (call.method) {
      "getApps" -> {
        val bundleIdPrefix: String = call.argument("bundleIdPrefix") ?: ""
        val includeSystemApps = call.argument("includeSystemApps") ?: true
        val includeIcons = call.argument("includeIcon") ?: false
        val permissions:List<String> = call.argument("permissions") ?: listOf()
        val shouldHasAllPermissions = call.argument("hasAllPermissions") ?: true
        Thread {
          val apps: List<Map<String, Any?>> = getApps(bundleIdPrefix, includeSystemApps,
            includeIcons, permissions, shouldHasAllPermissions)
          result.success(apps)
        }.start()
      }
      "getSystemApps" -> {
        val bundleIdPrefix: String = call.argument("bundleIdPrefix") ?: ""
        val includeIcons = call.argument("includeIcon") ?: false
        val permissions:List<String> = call.argument("permissions") ?: listOf()
        val shouldHasAllPermissions = call.argument("hasAllPermissions") ?: true
        Thread {
          val apps: List<Map<String, Any?>> = getSystemApps(bundleIdPrefix,
            includeIcons, permissions, shouldHasAllPermissions)
          result.success(apps)
        }.start()
      }
      "getAppsBundleIds" -> {
        val bundleIdPrefix: String = call.argument("bundleIdPrefix") ?: ""
        val includeSystemApps = call.argument("includeSystemApps") ?: true
        val permissions:List<String> = call.argument("permissions") ?: listOf()
        val shouldHasAllPermissions = call.argument("hasAllPermissions") ?: true
        Thread {
          val apps: List<String> = getAppsBundleIds(bundleIdPrefix, includeSystemApps,
            permissions, shouldHasAllPermissions)
          result.success(apps)
        }.start()
      }
      "startApp" -> result.success(launchApp(call.argument("bundleId") ?: ""))
      "getAppInfo" -> result.success(getAppInfo(call.argument("bundleId") ?: ""))
      "isSystemApp" -> result.success(AppUtil.isSystemApp(call.argument("bundleId") ?: ""))
      "openAppSetting" -> openAppSetting(call.argument("bundleId") ?: "")
      else -> result.notImplemented()
    }
  }

  private fun getApps(bundleIdPrefix: String,
                      includeSystemApps: Boolean,
                      includeIcons: Boolean,
                      permissions:List<String>,
                      shouldHasAllPermissions: Boolean): List<Map<String, Any?>> {
    var apps = context!!.packageManager.getInstalledApplications(0)
    apps = AppUtil.filterApps(apps, bundleIdPrefix, includeSystemApps, onlySystemApps = false,
      permissions, shouldHasAllPermissions)
    return apps.map { app -> AppUtil.appToHashMap(app, includeIcons) }
  }

  private fun getSystemApps(bundleIdPrefix: String,
                            includeIcons: Boolean,
                            permissions:List<String>,
                            shouldHasAllPermissions: Boolean): List<Map<String, Any?>> {
    var apps = context!!.packageManager.getInstalledApplications(0)
    apps = AppUtil.filterApps(apps, bundleIdPrefix,includeSystemApps = true,
      onlySystemApps = true, permissions, shouldHasAllPermissions)
    return apps.map { app -> AppUtil.appToHashMap(app, includeIcons) }
  }

  private fun getAppsBundleIds(bundleIdPrefix: String,
                                  includeSystemApps: Boolean,
                                  permissions:List<String>,
                                  shouldHasAllPermissions: Boolean): List<String> {
    var apps = context!!.packageManager.getInstalledApplications(0)
    apps = AppUtil.filterApps(apps, bundleIdPrefix, includeSystemApps, onlySystemApps = false,
      permissions, shouldHasAllPermissions)
    return apps.map { app -> app.packageName }
  }

  private fun launchApp(bundleId: String) {
    if (bundleId.isBlank()) {
      Log.e(TAG, "Error launching App ~~~> BundleId is empty!!!")
      return
    }
    try {
      context!!.startActivity(context?.packageManager?.getLaunchIntentForPackage(bundleId))
    } catch (e: Exception) {
      Log.e(TAG, "Error launching app ~~~> ${e.localizedMessage}")
    }
  }

  private fun openAppSetting(bundleId: String) {

    try {
      val intent = Intent()
      intent.flags = FLAG_ACTIVITY_NEW_TASK
      intent.action = ACTION_APPLICATION_DETAILS_SETTINGS
      val uri = Uri.fromParts("package", bundleId, null)
      intent.data = uri
      context!!.startActivity(intent)
    } catch (e: Exception) {
      Log.e(TAG, "Error opening app setting ~~~> ${e.localizedMessage}")
    }

  }

  private fun getAppInfo(bundleId: String): Map<String, Any?>? {
    var installedApps = context?.packageManager?.getInstalledApplications(0)
    installedApps = installedApps!!.filter { app -> app.packageName == bundleId }
    return if (installedApps.isEmpty()) null
    else AppUtil.appToHashMap(installedApps[0], true)
  }
}
