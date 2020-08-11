import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trtc_jz_flutter/trtc_jz_flutter.dart';

void main() {
  const MethodChannel channel = MethodChannel('trtc_jz_flutter');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await TrtcJzFlutter.platformVersion, '42');
  });
}
