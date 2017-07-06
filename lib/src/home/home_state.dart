import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:convert';

import 'package:image_picker/image_picker.dart';

import 'package:chui/src/config.dart';
import 'package:chui/src/home/home_screen.dart';
import 'package:chui/src/components/x.dart';

class HomeState extends State<HomeScreen> {
  var imageFile;
  var spoofed = 'Waiting for input';

  getImage() async {
    var fileName = await ImagePicker.pickImage();
    setState(() {
      imageFile = fileName;
      spoofed = 'Detecting...';
    });
    detectSpoofing();
  }

  detectSpoofing() async {
    var bytes = imageFile.readAsBytesSync();
    var base64 = BASE64.encode(bytes);

    var url = Config.chuiEndPoint;
    var httpClient = createHttpClient();
    var response = await httpClient.post(url,
        headers: {
          'Content-type': 'application/json',
          'x-api-key': Config.chuiApiKey
        },
        body: new JsonEncoder().convert({'img': base64.toString()}));

    var status = 'Success';
    if (response.statusCode != 200) {
      status = 'Failed';
    }

    setState(() {
      spoofed = status;
    });

    if (response.statusCode == 200) {
      var res = new JsonCodec().decode(response.body);
      setState(() {
        spoofed = '${res['data']['class']} (score ${res['data']['score']})';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new XAppBar(
        platform: Theme.of(context).platform,
        title: new Text('Spoof Detection'),
      ),
      body: new Center(
          child: new Container(
        padding: new EdgeInsets.all(12.0),
        child: new Column(
          children: <Widget>[
            new Expanded(
                flex: 0,
                child: new Container(
                  padding: new EdgeInsets.all(12.0),
                  child: new Text(spoofed),
                )),
            new Expanded(
                flex: 1,
                child: imageFile == null
                    ? new Text('No image selected.')
                    : new Image.file(imageFile)),
          ],
        ),
      )),
      floatingActionButton: new FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: new Icon(Icons.add_a_photo),
      ),
    );
  }
}
