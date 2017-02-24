// Copyright (c) 2017, pablo.mestre. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:angular2_components/angular2_components.dart';
import 'package:pamescan/services/service_firebase.dart';

import 'package:pamescan/items/SimplePost.dart';
import 'package:pamescan/components/cards/card_simple_post_edit.dart';
import 'package:pamescan/components/cards/card_simple_post.dart';

import 'package:pamescan/utils/utils.dart';

@Component(
  selector: 'page-gallery',
  styleUrls: const ['page_gallery.css'],
  templateUrl: 'page_gallery.html',
  directives: const [materialDirectives, CardSimplePost, CardSimplePostEdit],
  providers: const [FirebaseService],
  )
class PageGallery {
  final FirebaseService firebaseService;

  bool showDialog = false;
  SimplePost selectedPost;
  bool get isUserLogged=> firebaseService.isUserLogged;


  PageGallery(this.firebaseService) {
    selectedPost = new SimplePost("");
  }

  onAddItemClick() {
    var color1=utils.getRandomBasicColor();
    var color2=utils.getRandomBasicColor();
    SimplePost simplePost = new SimplePost("Text", "Title", "https://dummyimage.com/317x211/${color1}/${color2}&text=test",firebaseService.user?.displayName,firebaseService.user?.uid);
    firebaseService.postItem(simplePost);
  }

  onDeleteItem(key) {
    firebaseService.delItem(key);
  }

  onEditItem(key) {
    selectedPost = firebaseService.getItem(key);
    showDialog = true;
  }

  updateItem(event) {
    showDialog = false;
    firebaseService.updateItem(event);
  }

  test(key) {
    print(key.toString());
  }
}
