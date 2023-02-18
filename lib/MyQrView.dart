import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const myQrView = 'myQrView';

class MyQrView extends StatelessWidget {
  const MyQrView(
      {required this.text,
      required this.width,
      required this.height,
      super.key});

  final String text;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    // Pass parameters to the platform side.
    final Map<String, dynamic> creationParams = <String, dynamic>{};
    creationParams["text"] = text;
    creationParams["width"] = width;
    creationParams["height"] = height;

    return Platform.isAndroid
        ? AndroidView(
            viewType: myQrView,
            layoutDirection: TextDirection.ltr,
            creationParams: creationParams,
            creationParamsCodec: const StandardMessageCodec(),
          )
        : UiKitView(
            viewType: myQrView,
            layoutDirection: TextDirection.ltr,
            creationParams: creationParams,
            creationParamsCodec: const StandardMessageCodec(),
          );
  }
}
