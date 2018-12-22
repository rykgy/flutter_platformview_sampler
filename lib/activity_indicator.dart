import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UIActivityIndicator extends StatefulWidget {

  MethodChannel _channel = new MethodChannel('plugins/activity_indicator');

  Future<void> start() async {
    return _channel.invokeMethod('start');
  }

  Future<void> stop() async {
    return _channel.invokeMethod('stop');
  }

  @override
  State<StatefulWidget> createState() => _UIActivityIndicatorState();
}

class _UIActivityIndicatorState extends State<UIActivityIndicator> {

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return UiKitView(
        viewType: "plugins/activity_indicator",
      );
    }
    return Text(
        '$defaultTargetPlatform is not yet supported by the activity_indicator plugin');
  }
}
