// Copyright (c) 2017, pablo.mestre. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:angular2_components/angular2_components.dart';
import 'package:angular2/router.dart';

import 'package:pamescan/services/service_firebase.dart';
import 'package:pamescan/services/service_message.dart';

import 'package:pamescan/pages/index/page_index.dart';
import 'package:pamescan/pages/error/page_error.dart';
import 'package:pamescan/pages/gallery/page_gallery.dart';
import 'package:pamescan/pages/message/page_message.dart';
import 'package:pamescan/components/cards/card_simple_post_edit.dart';
import 'package:pamescan/components/new_post/new_post.dart';

@Component(
  selector: 'app-main',
  styleUrls: const ['app_main.css'],
  templateUrl: 'app_main.html',
  directives: const [materialDirectives, ROUTER_DIRECTIVES, PageIndex, PageError, PageMessage, CardSimplePostEdit, NewPost],
  providers: const [materialProviders, FirebaseService, MessageService],
  )
@RouteConfig(const [
               const Route(path: '/index', name: 'Index', component: PageIndex),
               const Route(path: '/gallery', name: 'Gallery', component: PageGallery, useAsDefault: true),
               const Route(path: '/messages', name: 'Messages', component: PageMessage),
               const Route(path: '/error', name: 'Error', component: PageError),
               const Route(path: '/user/:id', name: 'User', component: PageError)
             ])
class AppMain {
  final FirebaseService firebaseService;
  final Router _router;

  bool showDialog = false;

  bool get isUserLogged => firebaseService.isUserLogged;

  AppMain(this._router, this.firebaseService) {

  }


  onLogin() {
    firebaseService.loginWithGoogle();
    _router.navigate(['Gallery']);
  }

  onLogOut() {
    firebaseService.logOut();
    _router.navigate(['Index']);
  }


}
