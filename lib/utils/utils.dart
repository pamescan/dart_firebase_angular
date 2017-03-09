// Copyright (c) 2017, pablo.mestre. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.


import 'dart:math';
import 'dart:html';
import 'dart:typed_data';

class utils {
  static randomRangeValue(int max) {
    var rng = new Random();

    return rng.nextInt(max);
  }

  static dataURItoBlob(CanvasElement canvas,{String mimeType:'image/jpeg'}) {
    var dataUri = canvas.toDataUrl(mimeType);
    var byteString = window.atob(dataUri.split(',')[1]);
    //var mimeString = dataUri.split(',')[0].split(':')[1].split(';')[0];
    var arrayBuffer = new Uint8List(byteString.length);
    var dataArray = new Uint8List.view(arrayBuffer.buffer);
    for (var i = 0; i < byteString.length; i++) {
      dataArray[i] = byteString.codeUnitAt(i);
    }
    var blob = new Blob([arrayBuffer], mimeType);
    return blob;
  }

  static String getRandomBasicColor() {
    return colors[randomRangeValue(colors.length)];
  }

  static List colors = [
    'f44336',
    'E91E63',
    '9C27B0',
    '673AB7',
    '3F51B5',
    '2196F3',
    '03A9F4',
    '00BCD4',
    '009688',
    '4CAF50',
    '8BC34A',
    'CDDC39',
    'FFEB3B',
    'FFC107',
    'FF9800',
    'FF5722',
    '795548',
    '9E9E9E',
    '607D8B'
  ];
}

class Color {
  String name;
  String value;
}

