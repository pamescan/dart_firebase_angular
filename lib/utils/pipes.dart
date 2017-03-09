// Copyright (c) 2017, pablo.mestre. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.


import 'package:angular2/angular2.dart';

@Pipe(name: 'reverse')
class ReversePipe extends PipeTransform {


  transform(value) {
    return value.reversed.take(5);
  }

}