// Copyright (c) 2017, pablo.mestre. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:angular2_components/angular2_components.dart';
import 'package:pamescan/services/service_firebase.dart';

import 'package:pamescan/items/SimplePost.dart';
import 'package:pamescan/components/cards/card_simple_post_edit.dart';
import 'package:pamescan/components/cards/card_simple_post.dart';


@Component(
  selector: 'page-gallery',
  styleUrls: const ['page_gallery.css'],
  templateUrl: 'page_gallery.html',
  directives: const [materialDirectives, CardSimplePost, CardSimplePostEdit],
  providers: const [FirebaseService],
  )
class PageGallery {
  final FirebaseService fbs;

  bool showDialog = false;
  SimplePost selectedPost;


  PageGallery(this.fbs) {
    selectedPost = new SimplePost("");
  }

  onAddItemClick() {
    SimplePost simplePost = new SimplePost("a", "b", "https://dummyimage.com/317x211/000/fff&text=example");
    fbs.postItem(simplePost);
  }

  onDeleteItem(key) {
    fbs.delItem(key);
  }

  onEditItem(key) {
    selectedPost = fbs.getItem(key);
    showDialog = true;
  }

  updateItem(event) {
    showDialog = false;
    fbs.updateItem(event);
  }

  test(key) {
    print(key.toString());
  }
}
