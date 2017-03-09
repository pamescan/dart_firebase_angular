// Copyright (c) 2017, pablo.mestre. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:pamescan/items/SimplePost.dart';
import 'package:angular2_components/angular2_components.dart';
import 'dart:html';

@Component(
  selector: 'card-simple-post-edit',
  styleUrls: const ['card_simple_post.css'],
  templateUrl: 'card_simple_post_edit.html',
  directives: const [materialDirectives],
  providers: const [],
)
class CardSimplePostEdit implements OnChanges, OnInit {
  @Input()
  SimplePost post;
  @Input()
  bool isVisible;
  @Output()
  EventEmitter<SimplePost> onUpdate = new EventEmitter<SimplePost>();
  @Output()
  EventEmitter onCancel = new EventEmitter();
  @Output()
  EventEmitter isVisibleChange = new EventEmitter();
  @Output()
  EventEmitter<File> file = new EventEmitter<File>();

  CanvasElement canvas;
  SimplePost tempPost;

  ngOnInit() {
    canvas = querySelector('#image_canvas');
  }

  ngOnChanges(changes) {}

  onClickUpdate() {
    this.onUpdate.emit(post);
  }

  onClickCancel() {
    this.isVisibleChange.emit(false);
  }
}
