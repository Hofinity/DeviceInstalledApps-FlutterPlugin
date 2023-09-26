package com.hofinity.device_installed_apps

import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.drawable.BitmapDrawable
import android.graphics.drawable.Drawable
import android.os.Build
import java.io.ByteArrayOutputStream

object DrawableUtils {
    internal fun drawableToByteArray(drawable: Drawable): ByteArray {
        val stream = ByteArrayOutputStream()
        drawableToBitmap(drawable).compress(Bitmap.CompressFormat.PNG, 100, stream)
        return stream.toByteArray()
    }

    private fun drawableToBitmap(drawable: Drawable): Bitmap {
        if(Build.VERSION.SDK_INT <= Build.VERSION_CODES.N_MR1) return (drawable as BitmapDrawable).bitmap
        val bitmap = Bitmap.createBitmap(drawable.intrinsicWidth,drawable.intrinsicHeight,Bitmap.Config.ARGB_8888)
        val canvas = Canvas(bitmap)
        drawable.setBounds(0, 0, canvas.width, canvas.height)
        drawable.draw(canvas)
        return bitmap
    }
}