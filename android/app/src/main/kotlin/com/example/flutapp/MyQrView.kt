package com.example.flutapp

import android.content.Context
import android.graphics.Bitmap
import android.graphics.Color
import android.view.View
import android.widget.ImageView
import com.google.zxing.BarcodeFormat
import com.google.zxing.EncodeHintType
import com.google.zxing.qrcode.QRCodeWriter
import io.flutter.plugin.platform.PlatformView

class MyQrView(context: Context, id: Int, creationParams: Map<String?, Any?>?) : PlatformView {
    private val imageView: ImageView

    override fun getView(): View {
        return imageView
    }

    override fun dispose() {}

    init {
        imageView = ImageView(context)
        imageView.setImageBitmap(getQrCodeBitmap(creationParams?.get("text")?.toString()))
    }

    private fun getQrCodeBitmap(text: String?): Bitmap {
        val size = 512
        val hints = hashMapOf<EncodeHintType, Int>().also {
            it[EncodeHintType.MARGIN] = 1
        } // Make the QR code buffer border narrower
        val bits = QRCodeWriter().encode(text, BarcodeFormat.QR_CODE, size, size, hints)
        val bitmap = Bitmap.createBitmap(size, size, Bitmap.Config.RGB_565).also {
            for (x in 0 until size) {
                for (y in 0 until size) {
                    it.setPixel(x, y, if (bits[x, y]) Color.BLACK else Color.WHITE)
                }
            }
        }
        return bitmap
    }
}