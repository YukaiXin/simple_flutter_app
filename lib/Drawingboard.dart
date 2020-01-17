import 'package:flutter/material.dart';

class SignaturePainter extends CustomPainter {
  SignaturePainter(this.points);

  final List<Offset> points;

  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.lightBlue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null)
        canvas.drawLine(points[i], points[i + 1], paint);
    }
  }

  bool shouldRepaint(SignaturePainter other) => other.points != points;
}

class Signature extends StatefulWidget {
  SignatureState createState() => new SignatureState();
}

class SignatureState extends State<Signature> {
  List<Offset> _points = <Offset>[];

  Widget build(BuildContext context) {
    return new Stack(
      children: [
        GestureDetector(
        onTap: ()
        {
          print("tap");
        },
          onDoubleTap: (){
            print("清空画板！");
            print(_points);
            setState(() {
              _points.clear();
            });
          },
          onPanUpdate: (DragUpdateDetails details) {
            RenderBox referenceBox = context.findRenderObject();
            Offset localPosition = referenceBox.globalToLocal(details.globalPosition);

            setState(() {
              _points = new List.from(_points)..add(localPosition);
            });
          },
          onPanEnd: (DragEndDetails details) => _points.add(null),
        ),
        CustomPaint(painter: new SignaturePainter(_points)),
      ],
    );
  }
}

class DemoApp extends StatelessWidget {
  Widget build(BuildContext context) => new Scaffold(
      body: new Center(
        child: new Signature()
      ),
      floatingActionButton: new GestureDetector(
        child: new Icon(Icons.brush),
        onTap: (){
          print("clicking ...");
        },
      ),




  );
}

void main() => runApp(new MaterialApp(home: new DemoApp()));