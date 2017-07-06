import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class XAppBar extends AppBar {
  XAppBar({
    Key key,
    TargetPlatform platform,
    Widget title,
    Widget body,
  })
      : super(
          key: key,
          elevation: platform == TargetPlatform.iOS ? 0.0 : 4.0,
          title: title,
        );
}
