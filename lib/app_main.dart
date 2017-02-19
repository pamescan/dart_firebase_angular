// Copyright (c) 2017, pablo.mestre. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.
//import 'dart:async';

import 'package:angular2/core.dart';
import 'package:angular2_components/angular2_components.dart';
import 'package:angular2/router.dart';
//import 'package:angular2/platform/common.dart';


import 'package:pamescan/app_header.dart';
import 'package:pamescan/pages/index/page_index.dart';
import 'package:pamescan/pages/error/page_error.dart';
import 'package:pamescan/pages/gallery/page_gallery.dart';

@Component(
  selector: 'app-main',
  styleUrls: const ['app_main.css'],
  templateUrl: 'app_main.html',
  directives: const [materialDirectives, ROUTER_DIRECTIVES, PageIndex, PageError, AppHeader],
  providers: const [materialProviders],
  )
@RouteConfig(const [
               const Route(path: '/index', name: 'Index', component: PageIndex, useAsDefault: true),
               const Route(path: '/gallery', name: 'Gallery', component: PageGallery),

               const Route(path: '/error', name: 'Error', component: PageError)

             ])
class AppMain {
  //final RouteParams _routeParams;

  //final Location _location;

  //AppMain(this._location, this._routeParams);
  AppMain();

}
