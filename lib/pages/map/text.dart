import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _panelHeight = 200.0; // Initial height of the panel
  bool _isPanelExpanded = false; // Flag to track panel expansion

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            color: Colors.blue, // Main content area
            child: Center(
              child: Text('Main Content'),
            ),
          ),
        ),
        GestureDetector(
          onVerticalDragUpdate: (details) {
            setState(() {
              _panelHeight -=
                  details.primaryDelta!; // Adjust panel height based on drag
              _isPanelExpanded = false; // Panel is being dragged, not expanded
            });
          },
          onVerticalDragEnd: (details) {
            if (!_isPanelExpanded) {
              setState(() {
                // Ensure the panel cannot be minimized below a certain height
                _panelHeight = _panelHeight.clamp(200.0, double.infinity);
              });
            }
          },
          child: Container(
            height: _panelHeight,
            color: Colors.white, // Panel background color
            child: Center(
              child: Text('Panel Content'),
            ),
          ),
        ),
      ],
    );
  }
}
