/*
 * @Descripttion: 
 * @Author: xuci
 * @Date: 2020-08-11 14:11:04
 */
import 'package:flutter/services.dart';

class JZTRTCPluginManager {
  static const MethodChannel _channel =
      const MethodChannel('com.jz.TrtcJzFlutterView');

  /// 初始化双录 SDK.
  static Future<dynamic> initTrtcLocalUser(
      String userId, String sdkappid, String userSig, String roomId) async {
    var result = await _channel.invokeMethod('initTrtcLocalUser', {
      'userId': userId,
      'sdkappid': sdkappid,
      'userSig': userSig,
      'roomId': roomId
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
}
