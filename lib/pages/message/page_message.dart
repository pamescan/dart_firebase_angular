// Copyright (c) 2017, pablo.mestre. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import "dart:html";
import 'package:angular2/core.dart';
import 'package:pamescan/services/service_message.dart';
import 'package:pamescan/directives/vu_hold_focus.dart';
import 'package:pamescan/directives/vu_scroll_down.dart';


@Component(
  selector: 'page-messages',
  styleUrls: const ['page_message.css'],
  templateUrl: 'page_message.html',
  directives: const [VuHoldFocus,VuScrollDown],
  providers: const [],
  )
class PageMessage {
  final MessageService msgService;




  PageMessage(this.msgService) {

  }

  void sendTextMessage() {
    var inputText = querySelector("#messageText");
    String messageText = inputText.value.trim();

    if (messageText.isNotEmpty) {
      msgService.sendMessage(text: messageText);
      inputText.value = "";
    }
  }

}
