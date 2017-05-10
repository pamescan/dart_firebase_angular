// Copyright (c) 2017, pablo.mestre. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:pamescan/models/SimplePost.dart';
import 'package:angular2_components/angular2_components.dart';
import 'package:pamescan/services/service_firebase.dart';
import 'dart:html';
import 'dart:async';
import 'package:pamescan/utils/utils.dart';
import 'package:lorem/lorem.dart';

@Component(
  selector: 'new-post',
  styleUrls: const ['new_post.css'],
  templateUrl: 'new_post.html',
  directives: const [materialDirectives],
  providers: const [],
  )
class NewPost implements OnChanges, OnInit {
  @Input()
  String editKey = "";

  final FirebaseService firebaseService;
  bool showDialog = false;

  SimplePost post;

  CanvasElement canvas;
  CanvasRenderingContext2D ctx;

  NewPost(this.firebaseService) {
    canvas = new CanvasElement();
    ctx = canvas.getContext("2d");
    post = new SimplePost("");
  }

  onClickCamera(e) {
    post = new SimplePost("");
    var fileList = e.target as FileUploadInputElement;
    if (fileList.files.length > 0) {
      File file = fileList.files[0];
      if (!file.type.contains('image/')) {
        // this file is not an image.
        return;
      }

      showDialog = true;
      _image(file);
    }
  }

  ngOnInit() {}

// Detects changes on input data
  ngOnChanges(changes) {
    var key = changes['editKey'].currentValue;
    if (key == null) return;
    showDialog = true;

    post = new SimplePost.fromMap(SimplePost.toMap(firebaseService.getItem(key)));
    _drawImageOnCanvas(post.imageUrl);



  }
  _drawImageOnCanvas(String imageUrl){
    ImageElement img = new ImageElement();
    CanvasElement visibleCanvas = querySelector("#visible_canvas");
    CanvasRenderingContext2D ctxVisible = visibleCanvas.getContext("2d");
    img.src = imageUrl;
    ctxVisible.drawImageScaled(img, 0, 0, visibleCanvas.width, visibleCanvas.height);
  }

  onClickSave() async {

    post.userName = firebaseService.user?.displayName;
    post.userKey = firebaseService.user?.uid;

    showDialog = false;
    if (post.key != null) {
      firebaseService.updateItem(post);
    } else {
      var imageUrl = await _sendFileToFirebase(utils.dataURItoBlob(canvas));
      post.imageUrl = imageUrl;
      firebaseService.postItem(post);
    }
  }

  onClickCancel() {
    showDialog = false;
  }

  _image(File file) {
    ImageElement img = new ImageElement();

    CanvasElement visibleCanvas = querySelector("#visible_canvas");

    CanvasRenderingContext2D ctxVisible = visibleCanvas.getContext("2d");

    img.src = Url.createObjectUrl(file);

    img.onLoad.listen((value) {
      var MAX_WIDTH = 800;
      var MAX_HEIGHT = 600;
      var width = img.width;
      var height = img.height;

      if (width > height) {
        if (width > MAX_WIDTH) {
          height *= MAX_WIDTH / width;
          width = MAX_WIDTH;
        }
      } else {
        if (height > MAX_HEIGHT) {
          width *= MAX_HEIGHT / height;
          height = MAX_HEIGHT;
        }
      }
      canvas.width = width.toInt();
      canvas.height = height.toInt();
      ctx.drawImageScaled(img, 0, 0, canvas.width, canvas.height);
      ctxVisible.drawImageScaled(img, 0, 0, visibleCanvas.width, visibleCanvas.height);
    });
  }

// Send a new file to firebase storage and obtains file url
  Future<String> _sendFileToFirebase(file, {String filename}) async {
    var filename = "${firebaseService.user.uid}_${file.hashCode.toString()}.jpg";
    String Url;

    await firebaseService.addFile('post',file, filename).then((e) {
      Url = e;
    });
    return Url;
  }

// Create a new fake post with random values
  fakePost() {
    var color1 = utils.getRandomBasicColor();
    var color2 = utils.getRandomBasicColor();
    Lorem lorem = new Lorem();
    lorem.createText(numParagraphs: 2, numSentences: 2);
    SimplePost post = new SimplePost(
        lorem.createText(numParagraphs: 2, numSentences: 1),
        lorem.createSentence(sentenceLength: 5),
        "https://dummyimage.com/317x211/${color1}/${color2}&text=${lorem.createSentence(sentenceLength: 3) }",
        firebaseService.user?.displayName,
        firebaseService.user?.uid);
    firebaseService.postItem(post);
  }
}
