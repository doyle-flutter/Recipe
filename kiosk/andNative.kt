
import android.content.Intent
import androidx.annotation.NonNull
import android.net.Uri
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    companion object{
        const val CHANNEL = "samples.flutter.dev/action";
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            val phNumber = call.argument<String>("number")
            if(call.method == "callFunc"){
                this.flutterCall(phNumber.toString())
            }
            return@setMethodCallHandler
        }
    }

    private fun flutterCall(number:String) {
        val uri = Uri.parse("tel:$number")
        val intent = Intent(Intent.ACTION_DIAL, uri)
        startActivity(intent)
    }
}
