// Copyright (c) 2017, pablo.mestre. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/platform/browser.dart';

import 'package:pamescan/app_main.dart';

import 'package:http/browser_client.dart';
import 'package:http/http.dart';
import 'package:firebase/firebase.dart';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:angular2/angular2.dart';
import 'package:angular2/platform/common.dart';

main() {
  initializeApp(
      apiKey: "TODO",
      authDomain: "TODO",
      databaseURL: "TODO",
      storageBucket: "TODO");
  bootstrap(AppMain, [
    ROUTER_PROVIDERS,
    provide(APP_BASE_HREF, useValue: '/'),
    provide(LocationStrategy, useClass: HashLocationStrategy),
    [provide(Client, useFactory: () => new BrowserClient(), deps: [])]
  ]);
}
