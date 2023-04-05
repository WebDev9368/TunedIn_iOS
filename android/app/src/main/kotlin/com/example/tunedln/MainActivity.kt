package com.example.tunedln;

import io.flutter.embedding.android.FlutterActivity;
import androidx.annotation.NonNull;
import io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin;
import io.flutter.embedding.engine.FlutterEngine;

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        flutterEngine.getPlugins().add(SharedPreferencesPlugin());

    }
}
