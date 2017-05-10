// Copyright (c) 2017, pablo.mestre. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:pamescan/models/message.dart';
import 'dart:async';
import 'package:pamescan/services/service_firebase.dart';
import 'package:firebase/firebase.dart' as fb;

@Injectable()
class MessageService {
  //final FirebaseService fbService;
  static const String path = "message";
  fb.DatabaseReference _databaseRef;
  fb.StorageReference _storageRef;
  fb.UserInfo _user;
  List<Message>messages = [];

  //var databaseRef;
  //var storageRef;

  MessageService() {
//    databaseRef = fbService.databaseRef.child("messages");
//    storageRef = fbService.databaseRef.child("messages");
  }

  load(fb.DatabaseReference dbref, fb.StorageReference stref, fb.UserInfo user) {
    this._databaseRef = dbref.child(path);
    this._storageRef = stref.child(path);
    this._user = user;
     _setMessageListener();
  }

  clear() {
    this.messages = [];
  }

  _setMessageListener() {
    // Setups listening on the child_changed event on the database Message ref
    _databaseRef.onChildChanged.listen((e) {
      //_onChildChanged(e.snapshot.key, e.snapshot.val());
    });
    // Setups listening on the child_added event on the database Message ref.
    _databaseRef
        .limitToLast(12)
        .onChildAdded
        .listen((e) {
      _onChildAdded(e.snapshot.val());
    });
    // Setups listening on the child_removed event on the database Message ref.
    _databaseRef.onChildRemoved.listen((e) {
      //_onChildRemoved(e.snapshot.key, e.snapshot.val());
    });
  }

  _onChildAdded(Map map) {
    Message msg = new Message.fromMap(map);
    this.messages.add(msg);
  }

  Future sendMessage({String text, String imageUrl}) async {
    try {
      Message msg = new Message(this._user.displayName, text, this._user.photoURL, imageUrl);
      await _databaseRef.push(msg.toMap());
    } catch (error) {
      print("$runtimeType::sendMessage() -- $error");
    }
  }
}