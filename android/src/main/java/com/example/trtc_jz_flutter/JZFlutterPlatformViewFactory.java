/*
 * @Descripttion: 
 * @Author: xuci
 * @Date: 2020-08-20 10:15:02
 */
package com.example.trtc_jz_flutter;

import android.content.Context;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;
import io.flutter.plugin.common.PluginRegistry.Registrar;

public class JZFlutterPlatformViewFactory extends PlatformViewFactory {
    private final BinaryMessenger messenger;
    private final Registrar registrar;

    public JZFlutterPlatformViewFactory(Registrar registrar) {
        super(StandardMessageCodec.INSTANCE);
        this.messenger = registrar.messenger();
        this.registrar = registrar;

    }

    @Override
    public PlatformView create(Context context, int viewId, Object args) {
        return new JZFlutterPlatformView(context, viewId, args, this.registrar);
    }
}
