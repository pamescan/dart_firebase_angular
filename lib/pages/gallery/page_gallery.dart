// Copyright (c) 2017, pablo.mestre. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:angular2_components/angular2_components.dart';
import 'package:pamescan/services/service_firebase.dart' ;

import 'package:pamescan/items/SimplePost.dart';




@Component(
  selector: 'page-gallery',
  styleUrls: const ['page_gallery.css'],
  templateUrl: 'page_gallery.html',
  directives: const [materialDirectives],
  providers: const [FirebaseService],
  )

class PageGallery {
  final FirebaseService fbs;
  PageGallery(this.fbs);

  onAddItemClick(){
    SimplePost simplePost= new SimplePost("a","b","c");
    fbs.postItem(simplePost);
  }
  onDeleteItem(String key){
    fbs.delItem(key);
  }

}
