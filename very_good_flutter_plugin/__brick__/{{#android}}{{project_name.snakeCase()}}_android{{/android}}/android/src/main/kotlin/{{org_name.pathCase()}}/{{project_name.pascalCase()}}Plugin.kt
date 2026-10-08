package {{org_name.dotCase()}}

import {{project_name.pascalCase()}}Api
import io.flutter.embedding.engine.plugins.FlutterPlugin

class {{project_name.pascalCase()}}Plugin : FlutterPlugin, {{project_name.pascalCase()}}Api {
    companion object {
        private const val TAG = "{{project_name.pascalCase()}}Plugin"
    }

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        {{project_name.pascalCase()}}Api.setUp(binding.binaryMessenger, this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        {{project_name.pascalCase()}}Api.setUp(binding.binaryMessenger, null)
    }

    override suspend fun getPlatformName(): String? {
        return "Android ${android.os.Build.VERSION.RELEASE}"
    }
}