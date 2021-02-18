import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';

void main() {
  runApp(MaterialApp(
    title: 'Named Routes Demo',
    // Start the app with the "/" named route. In this case, the app starts
    // on the FirstScreen widget.
    initialRoute: '/',
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => MyList(),
      // When navigating to the "/second" route, build the SecondScreen widget.
      // '/second': (context) => OpenCamera(),
    },
  ));
}

class MyList extends StatefulWidget {
  @override
  _MyListState createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  int _cameraOcr = FlutterMobileVision.CAMERA_BACK;
  List<String> _listItems = [];
  final TextEditingController eCtrl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(title: const Text('MyReceiptScanner')),
        body: Center(
          child: new ListView.separated(
            shrinkWrap: false,
            separatorBuilder: (context, index) => Divider(
              color: Colors.teal,
            ),
            itemCount: _listItems.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(child: Text(_listItems[index])),
            ),
          ),
        ),
        floatingActionButton: new FloatingActionButton(
            child: new Icon(Icons.add),
            onPressed: () {
              _read();
            }));
  }

  Future<Null> _read() async {
    List<OcrText> text = [];
    try {
      text = await FlutterMobileVision.read(
        camera: _cameraOcr,
        waitTap: true,
        autoFocus: true,
      );

      setState(() {
        _listItems.add(text[0].value);
      });
    } on Exception {
      text.add(new OcrText("Text not recognized"));
    }
  }
}
