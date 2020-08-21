/*
 * @Descripttion: 
 * @Author: xuci
 * @Date: 2020-08-10 15:02:36
 */
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:trtc_jz_flutter/trtc_jz_flutter.dart';

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
  void initState() {
    super.initState();
  }

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

  Widget get localVideoView {
    if (Platform.isIOS) {
      return Container(
          width: 200,
          height: 100,
          child: UiKitView(
            viewType: 'com.jz.TrtcJzFlutterView',
            creationParams: <String, dynamic>{
              "text": "点击开始双录",
            },
            creationParamsCodec: const StandardMessageCodec(),
            onPlatformViewCreated: (id) {},
            hitTestBehavior: PlatformViewHitTestBehavior.opaque,
          ));
    } else {
      return Container(
        width: 200,
        height: 100,
        child: AndroidView(
          viewType: 'com.jz.TrtcJzFlutterViewAndroid',
          creationParams: {
            "myContent": "通过参数传入的文本内容,I am 原生view",
          },
          creationParamsCodec: const StandardMessageCodec(),
          hitTestBehavior: PlatformViewHitTestBehavior.opaque,
          onPlatformViewCreated: (id) {
            print(id);
          },
        ),
      );
    }
  }

  void _openDSRSDK() async {
    var result = await TrtcJzFlutter.initTrtcLocalUser(
        "123892189312831890", "0", "123213", "23123112321312312321421");
    var result1 = await TrtcJzFlutter.startLocalAudio();
    var result2 = await TrtcJzFlutter.startLocalPreview(true);
    print(result);
    print(result1);
    print(result2);
  }
}
