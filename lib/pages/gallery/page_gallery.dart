// Copyright (c) 2017, pablo.mestre. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:angular2_components/angular2_components.dart';
import 'package:pamescan/services/service_firebase.dart';

import 'package:pamescan/models/SimplePost.dart';
import 'package:pamescan/components/cards/card_simple_post_edit.dart';
import 'package:pamescan/components/cards/card_simple_post.dart';
import 'package:pamescan/components/new_post/new_post.dart';

@Component(
  selector: 'page-gallery',
  styleUrls: const ['page_gallery.css'],
  templateUrl: 'page_gallery.html',
  directives: const [materialDirectives, CardSimplePost, CardSimplePostEdit, NewPost],
  providers: const [FirebaseService],
)
class PageGallery {
  final FirebaseService firebaseService;

  bool showDialog = false;
  SimplePost selectedPost;
  SimplePost newPost;

  String editKey;

  bool get isUserLogged => firebaseService.isUserLogged;

  PageGallery(this.firebaseService) {}

  onAddItemClick() {}

  onDeleteItem(key) {
    firebaseService.delItem(key);
  }

  onEditItem(key) {
    editKey = key;
  }

  onCancelEdit(event) {}

  updateItem(event) {}
}
