package mn.fr099y.coronamongolia

import io.flutter.app.FlutterApplication
import android.content.Context
import androidx.multidex.MultiDex
import io.flutter.Log
import io.flutter.embedding.engine.FlutterShellArgs
import io.flutter.view.FlutterMain


class MyApp: FlutterApplication() {

    override fun onCreate() {
        super.onCreate()
        when(android.os.Build.MANUFACTURER){
            "HUAWEI"-> FlutterMain.ensureInitializationComplete(this, arrayOf<String>(FlutterShellArgs.ARG_ENABLE_SOFTWARE_RENDERING))
        }
        when(android.os.Build.MODEL){
            ""-> FlutterMain.ensureInitializationComplete(this, arrayOf<String>(FlutterShellArgs.ARG_ENABLE_SOFTWARE_RENDERING))
        }
    }

    override fun attachBaseContext(base: Context) {
        super.attachBaseContext(base)
        MultiDex.install(this)
    }
}