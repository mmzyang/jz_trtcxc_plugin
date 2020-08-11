/*
 * @Descripttion: 
 * @Author: xuci
 * @Date: 2020-08-06 16:42:19
 */
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TrtcJzFlutter {
  static const MethodChannel _channel = const MethodChannel('trtc_jz_flutter');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  /// 初始化双录 SDK.
  static Future<dynamic> initTrtcLocalUser(String userId, int roomId) async {
    var result = await _channel.invokeMethod(
        'initTrtcLocalUser', {'userId': userId, 'roomId': roomId});
    return result;
  }

  /// 退出房间
  static Future<dynamic> exitRoom() async {
    var result = await _channel.invokeMethod('exitRoom');
    return result;
  }

  /// 打开本地音频
  static Future<dynamic> startLocalAudio() async {
    var result = await _channel.invokeMethod('startLocalAudio');
    return result;
  }

  /// 打开本地视频
  static Future<dynamic> startLocalPreview(bool isFrontCamera) async {
    var result = await _channel
        .invokeMethod('startLocalPreview', {'isFrontCamera': isFrontCamera});
    return result;
  }
}
