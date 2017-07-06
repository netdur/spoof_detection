import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class XContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets margin;

  XContainer({Key key, this.child, this.margin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: child,
      margin: margin,
      decoration: Theme.of(context).platform == TargetPlatform.iOS
          ? new BoxDecoration(
              border: new Border(top: new BorderSide(color: Colors.grey[200])))
          : null,
    );
  }
}
