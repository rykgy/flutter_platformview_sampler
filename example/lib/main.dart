import 'package:flutter/material.dart';
import 'package:platformview_sampler/activity_indicator.dart';

void main() => runApp(MaterialApp(home: ActivityIndicatorExample()));

class ActivityIndicatorExample extends StatelessWidget {
  ActivityIndicatorController controller;

  void _onActivityIndicatorControllerWidgetCreated(ActivityIndicatorController _controller) {
    controller = _controller;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text('Flutter ActivityIndicator sampler')),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          UIActivityIndicator(
            hexColor: "FF0000",
            onActivityIndicatorWidgetCreated: _onActivityIndicatorControllerWidgetCreated,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 45.0, top: 0.0, bottom: 50.0, right: 45.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FloatingActionButton(
                  child: Text("Start"),
                  onPressed: () {
                    controller.start();
                  },
                ),
                new FloatingActionButton(
                  child: Text("Stop"),
                  onPressed: () {
                    controller.stop();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
