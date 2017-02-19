// Copyright (c) 2017, pablo.mestre. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.
//import 'dart:async';

import 'package:angular2/core.dart';
import 'package:angular2_components/angular2_components.dart';

import 'package:pamescan/services/service_firebase.dart';


@Component(
  selector: 'app-header',
  styleUrls: const ['app_main.css'],
  templateUrl: 'app_header.html',
  directives: const [materialDirectives],
  providers: const [FirebaseService],
  )
class AppHeader {
  final FirebaseService firebaseService;

   get showProfile => firebaseService.isUserLogged;

  AppHeader(this.firebaseService);

  onLogin() {
    firebaseService.loginWithGoogle();
  }

  onLogOut() {
    firebaseService.logOut();
  }


}
