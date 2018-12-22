import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef void UIActivityIndicatorWidgetCreatedCallback(ActivityIndicatorController controller);

class UIActivityIndicator extends StatefulWidget {

  const UIActivityIndicator({
    Key key,
    this.hexColor,
    this.onActivityIndicatorWidgetCreated,
  }) : super(key: key);

  final UIActivityIndicatorWidgetCreatedCallback onActivityIndicatorWidgetCreated;
  final String hexColor;

  @override
  State<StatefulWidget> createState() => _UIActivityIndicatorState();
}

class _UIActivityIndicatorState extends State<UIActivityIndicator> {

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return UiKitView(
        viewType: "plugins/activity_indicator",
        onPlatformViewCreated: _onPlatformViewCreated,
        creationParams: <String, dynamic>{
          "hexColor": widget.hexColor,
          "hidesWhenStopped": true,
        },
        creationParamsCodec: new StandardMessageCodec(),
      );
    }
    return Text(
        '$defaultTargetPlatform is not yet supported by the activity_indicator plugin');
  }

  void _onPlatformViewCreated(int id) {
    if (widget.onActivityIndicatorWidgetCreated == null) {
      return;
    }
    widget.onActivityIndicatorWidgetCreated(new ActivityIndicatorController._(id));
  }
}

class ActivityIndicatorController {

  ActivityIndicatorController._(int id)
      : _channel = MethodChannel('plugins/activity_indicator_$id');

  final MethodChannel _channel;

  Future<void> start() async {
    return _channel.invokeMethod('start');
  }

  Future<void> stop() async {
    return _channel.invokeMethod('stop');
  }
}
