package com.example.trtc_jz_flutter_example;

import android.os.Bundle;

import com.example.trtc_jz_flutter.JZFlutterPlatformView;
import com.example.trtc_jz_flutter.TrtcJzFlutterPlugin;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);
    }
}


