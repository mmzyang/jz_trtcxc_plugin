/*
 * @Descripttion: 
 * @Author: xuci
 * @Date: 2020-08-06 16:42:19
 */
import 'dart:async';
import 'package:flutter/services.dart';

class TrtcJzFlutter {
  static const MethodChannel _channel = const MethodChannel('trtc_jz_flutter');

  /// 初始化双录 SDK.
  static Future<dynamic> initTrtcLocalUser(
      String userId, String sdkappid, String userSig, String roomId) async {
    var result = await _channel.invokeMethod('initTrtcLocalUser', {
      'userid': userId,
      'sdkappid': sdkappid,
      'usersig': userSig,
      'roomid': roomId
    });
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

  /// 打开远端视频
  static Future<dynamic> startRemoteVideoView() async {
    var result = await _channel.invokeMethod('startRemoteVideoView');
    return result;
  }
}
