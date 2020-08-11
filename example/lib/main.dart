/*
 * @Descripttion: 
 * @Author: xuci
 * @Date: 2020-08-06 16:42:20
 */
import 'package:flutter/material.dart';
import 'package:trtc_jz_flutter_example/loader.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AppPage(),
    );
  }
}

class AppPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FlatButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return JZTRTCLoader();
                }));
              },
              child: Text("开始双录", style: TextStyle(fontSize: 20)))),
    );
  }
}
