import 'package:flutter/material.dart';



void main() => runApp(new MyApp());
// TapboxA 管理自身状态.

//------------------------- TapboxA ----------------------------------
class TapboxA extends StatefulWidget {
  TapboxA({Key key}) : super(key: key);

  @override
  _TapboxAState createState() => new _TapboxAState();
}

class _TapboxAState extends State<TapboxA> {
  bool _active = false;

  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: _handleTap,
      child: new Container(
        child: new Center(
          child: new Text(
            _active ? '管理自身状态' : '管理自身状态',
            style: new TextStyle(fontSize: 10.0, color: Colors.white),
          ),
        ),
        width: 100.0,
        height: 100.0,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(5),
        decoration: new BoxDecoration(
          color: _active ? Colors.lightGreen[700] : Colors.grey[600],
        ),
      ),
    );
  }
}

//------------------------- MyApp ----------------------------------

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Flutter Demo'),
        ),
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new TapboxA(),
              new ParentWidget(),
              new ParentWidget1()
            ],
          ),
        ),
      ),
    );
  }
}

// ParentWidget 为 TapboxB 管理状态.
//------------------------ ParentWidget --------------------------------
class ParentWidget extends StatefulWidget {
  @override
  _ParentWidgetState createState() => new _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  bool _active = false;

  void _handleTapboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new TapboxB(
        active: _active,
        onChanged: _handleTapboxChanged,
      ),
    );
  }
}

//------------------------- TapboxB ----------------------------------
class TapboxB extends StatelessWidget {
  TapboxB({Key key, this.active: false, @required this.onChanged})
      : super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged;

  void _handleTap() {
    onChanged(!active);
  }

  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: _handleTap,
      child: new Container(
        child: new Center(
          child: new Text(
            active ? '父widget管理widget的state' : '父widget管理widget的state',
            style: new TextStyle(fontSize: 10.0, color: Colors.white),
          ),
        ),
        width: 100.0,
        height: 100.0,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(5),
        decoration: new BoxDecoration(
          color: active ? Colors.redAccent : Colors.blueAccent,
        ),
      ),
    );
  }
}

//---------------------------- ParentWidget ----------------------------

class ParentWidget1 extends StatefulWidget {
  @override
  _ParentWidgetState1 createState() => new _ParentWidgetState1();
}

class _ParentWidgetState1 extends State<ParentWidget1> {
  bool _active = false;

  void _handleTapboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new TapboxC(
        active: _active,
        onChanged: _handleTapboxChanged,
      ),
    );
  }
}

//----------------------------- TapboxC ------------------------------

class TapboxC extends StatefulWidget {
  TapboxC({Key key, this.active: false, @required this.onChanged})
      : super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged;

  _TapboxCState createState() => new _TapboxCState();
}

class _TapboxCState extends State<TapboxC> {
  bool _highlight = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _highlight = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTap() {
    widget.onChanged(!widget.active);
  }

  Widget build(BuildContext context) {
    // This example adds a green border on tap down.
    // On tap up, the square changes to the opposite state.
    return new GestureDetector(
      onTapDown: _handleTapDown, // Handle the tap events in the order that
      onTapUp: _handleTapUp, // they occur: down, up, tap, cancel
      onTap: _handleTap,
      onTapCancel: _handleTapCancel,
      child: new Container(
        child: new Center(
          child: new Text(widget.active ? '混合管理！！！' : '混合管理###',
              style: new TextStyle(fontSize: 10.0, color: Colors.white)),
        ),
        width: 100.0,
        height: 100.0,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(5),
        decoration: new BoxDecoration(
          color:
          widget.active ? Colors.yellow : Colors.pink,
          border: _highlight
              ? new Border.all(
            color: Colors.lightBlueAccent,
            width: 5.0,
          )
              : null,
        ),
      ),
    );
  }
}