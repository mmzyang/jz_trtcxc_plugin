/*
 * @Descripttion: 
 * @Author: xuci
 * @Date: 2020-08-20 09:50:34
 */
package com.example.trtc_jz_flutter;

import android.content.Context;
import android.util.Log;
import android.view.View;
import android.widget.TextView;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import static io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import static io.flutter.plugin.common.MethodChannel.Result;
import static io.flutter.plugin.common.PluginRegistry.Registrar;


import io.flutter.plugin.platform.PlatformView;

public class JZFlutterPlatformView implements PlatformView, MethodCallHandler {

    private final TextView textView;
    private final MethodChannel methodChannel;
    private final Registrar registrar;
    private final int subviewId;

    JZFlutterPlatformView(Context context, int viewId, Object args, Registrar registrar) {
        this.subviewId = viewId;
        this.registrar = registrar;
        this.textView = new TextView(context);
        methodChannel = new MethodChannel(registrar.messenger(), "com.jz.TrtcJzFlutterViewAndroid");
        methodChannel.setMethodCallHandler(this);
    }

    @Override
    public View getView() {
        return textView;
    }

    @Override
    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        switch (methodCall.method) {
            case "setText":
                setText(methodCall, result);
                break;
            default:
                result.notImplemented();
        }

    }

    private void setText(MethodCall methodCall, Result result) {
        String text = (String) methodCall.arguments;
        textView.setText(text);
        result.success(null);
    }

    @Override
    public void dispose() {
        Log.d("TAG", "dispose: 测试一下");
    }
}
