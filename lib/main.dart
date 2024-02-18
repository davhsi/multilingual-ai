import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool showBubble = false;
  Offset bubbleOffset = Offset(20.0, 40.0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HSI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Boooooo'),
        ),
        body: Stack(
          children: [
            // Main content, buttons, etc. (replace with your actual content)
            Center(
              child: ElevatedButton.icon(
                icon: Icon(Icons.play_arrow),
                label: Text('Start'),
                onPressed: () => setState(() => showBubble = true),
              ),
            ),
            Visibility(
              visible: showBubble,
              child: Stack( // Use another Stack inside for better positioning
                children: [
                  Positioned( // Corrected placement for draggable bubble
                    left: bubbleOffset.dx,
                    top: bubbleOffset.dy,
                    child: Draggable(
                      child: _BubbleWidget(offset: bubbleOffset),
                      feedback: _BubbleWidget(offset: bubbleOffset),
                      childWhenDragging: Container(), // Hide while dragging
                      onDragEnd: (dragDetails) => setState(() => bubbleOffset = dragDetails.offset),
                    ),
                  ),
                  // Optional close button or other interactive elements
                  // positioned correctly within the inner Stack
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BubbleWidget extends StatelessWidget {
  final Offset offset;

  const _BubbleWidget({Key? key, required this.offset}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material( // Allow touch events to pass through
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('DAV'), // Customize with your desired content
        ),
      ),
    );
  }
}
