import 'package:flutter/material.dart';
import 'package:painter/painter.dart';
import 'package:provider/provider.dart';
import 'package:teknoloji_kimya_servis/providers/exploration%20report.dart';
import 'package:teknoloji_kimya_servis/providers/sign_provider.dart';

class DrawExplorationReportPage extends StatefulWidget {
  @override
  _DrawExplorationReportPageState createState() =>
      new _DrawExplorationReportPageState();
}

class _DrawExplorationReportPageState extends State<DrawExplorationReportPage> {
  bool _finished;
  PainterController _controller;

  @override
  void initState() {
    super.initState();
    _finished = false;
    _controller = _newController();
  }

  PainterController _newController() {
    PainterController controller = new PainterController();
    controller.thickness = 5.0;
    controller.backgroundColor = Colors.white;
    return controller;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> actions;
    if (_finished) {
      // actions = <Widget>[
      //   new IconButton(
      //     icon: new Icon(Icons.content_copy),
      //     tooltip: 'Ye',
      //     onPressed: () => setState(() {
      //       _finished = false;
      //       _controller = _newController();
      //     }),
      //   ),
      // ];
    } else {
      actions = <Widget>[
        new IconButton(
            icon: new Icon(
              Icons.undo,
            ),
            tooltip: 'Geri al',
            onPressed: () {
              if (_controller.isEmpty) {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) =>
                        new Text('Geri alacak bir sey yok'));
              } else {
                _controller.undo();
              }
            }),
        new IconButton(
            icon: new Icon(Icons.delete),
            tooltip: 'Temizle',
            onPressed: _controller.clear),
        new IconButton(
            icon: new Icon(Icons.check),
            onPressed: () => _show(_controller.finish(), context)),
      ];
    }
    return new Scaffold(
      backgroundColor: Colors.grey,
      appBar: new AppBar(
          title: const Text("Çizim"),
          actions: actions,
          bottom: new PreferredSize(
            child: new DrawBar(_controller),
            preferredSize: new Size(MediaQuery.of(context).size.width, 30.0),
          )),
      body: new Center(
        child: new AspectRatio(
          aspectRatio: 1.0,
          child: new Painter(
            _controller,
          ),
        ),
      ),
    );
  }

  Future<void> _show(PictureDetails picture, BuildContext context) async {
    setState(() {
      _finished = true;
    });
    final _uint8List = await picture.toPNG();
    Provider.of<ExplorationReportProvider>(context, listen: false)
        .addDraw(_uint8List);
    print("uint8List eklendi");
    Navigator.pop(context, true);
    return;
  }
}

class DrawBar extends StatelessWidget {
  final PainterController _controller;

  DrawBar(this._controller);

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Flexible(child: new StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return new Container(
              child: new Slider(
            value: _controller.thickness,
            onChanged: (double value) => setState(() {
              _controller.thickness = value;
            }),
            min: 0.0,
            max: 20.0,
            activeColor: Colors.white,
          ));
        })),
        new StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return new RotatedBox(
              quarterTurns: _controller.eraseMode ? 2 : 0,
              child: IconButton(
                icon: new Icon(Icons.create),
                tooltip:
                    (_controller.eraseMode ? 'Disable' : 'Enable') + ' eraser',
                onPressed: () {
                  setState(() {
                    _controller.eraseMode = !_controller.eraseMode;
                  });
                },
              ),
            );
          },
        ),
        // new ColorPickerButton(_controller, false),
        // new ColorPickerButton(_controller, true),
      ],
    );
  }
}

// class ColorPickerButton extends StatefulWidget {
//   final PainterController _controller;
//   final bool _background;

//   ColorPickerButton(this._controller, this._background);

//   @override
//   _ColorPickerButtonState createState() => new _ColorPickerButtonState();
// }

// class _ColorPickerButtonState extends State<ColorPickerButton> {
//   @override
//   Widget build(BuildContext context) {
//   return new IconButton(
//       icon: new Icon(_iconData, color: _color),
//       tooltip: widget._background
//           ? 'Change background color'
//           : 'Change draw color',
//       onPressed: _pickColor);
// }

// void _pickColor() {
//   Color pickerColor = _color;
//   Navigator.of(context)
//       .push(new MaterialPageRoute(
//           fullscreenDialog: true,
//           builder: (BuildContext context) {
//             return new Scaffold(
//                 appBar: new AppBar(
//                   title: const Text('Pick color'),
//                 ),
//                 body: new Container(
//                     alignment: Alignment.center,
//                     child:  ColorPicker(
//                       pickerColor: pickerColor,
//                       onColorChanged: (Color c) => pickerColor = c,
//                     ),),);
//           },),)
//       .then((_) {
//     setState(() {
//       _color = pickerColor;
//     });
//   });
// }

// Color get _color => widget._background
//     ? widget._controller.backgroundColor
//     : widget._controller.drawColor;

// IconData get _iconData =>
//     widget._background ? Icons.format_color_fill : Icons.brush;

// set _color(Color color) {
//   if (widget._background) {
//     widget._controller.backgroundColor = color;
//   } else {
//     widget._controller.drawColor = color;
//   }
// }
// }
