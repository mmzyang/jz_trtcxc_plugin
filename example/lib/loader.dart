/*
 * @Descripttion: 
 * @Author: xuci
 * @Date: 2020-08-10 15:02:36
 */
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:trtc_jz_flutter/trtc_jz_flutter.dart';
import 'package:trtc_jz_flutter_example/jztrtc_handle_manager.dart';

class JZVideoPlayerController {
  MethodChannel _channel;
  JZVideoPlayerController.init(int id) {
    _channel = new MethodChannel('com.jz.TrtcJzFlutterView$id');
  }

  Future<void> loadUrl(String url) async {
    assert(url != null);
    return _channel.invokeMethod('loadUrl', url);
  }
}

class JZTRTCLoader extends StatefulWidget {
  _JZTRTCLoaderState createState() => _JZTRTCLoaderState();
}

class _JZTRTCLoaderState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("双录开始"),
          actions: <Widget>[
            FlatButton(
                onPressed: _openDSRSDK,
                child: Text(
                  "点击开始",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ))
          ],
        ),
        body: Container(
          margin: EdgeInsets.fromLTRB(25, 50, 25, 200),
          child: localVideoView,
        ));
  }

  UiKitView get localVideoView {
    return UiKitView(
      viewType: 'com.jz.TrtcJzFlutterView',
      creationParams: <String, dynamic>{
        "x": 0,
        "y": 20,
        "width": 400,
        "height": 200,
        "text": "点击开始双录",
      },
      creationParamsCodec: const StandardMessageCodec(),
      onPlatformViewCreated: (id) {
        print("打印 id" + id.toString());
      },
      hitTestBehavior: PlatformViewHitTestBehavior.opaque,
    );
  }

  void _openDSRSDK() async {
    var result =
        await JZTRTCPluginManager.initTrtcLocalUser("123892189312831890", 1256732);
    var result1 = await JZTRTCPluginManager.startLocalAudio();
    var result2 = await JZTRTCPluginManager.startLocalPreview(true);
    print(result);
    print(result1);
    print(result2);
  }
}
