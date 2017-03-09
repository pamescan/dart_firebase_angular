// Copyright (c) 2017, pablo.mestre. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:angular2/core.dart';
import 'package:firebase/firebase.dart' as fb;

import 'package:pamescan/items/SimplePost.dart';

@Injectable()
class FirebaseService {
  final fb.Auth auth;
  final fb.DatabaseReference databaseRef;
  final fb.StorageReference storageRef;

  fb.UserInfo user; //logged user info
  List<SimplePost> _postList;

  bool get isUserLogged => user != null;

  get postList => _postList.reversed;

  FirebaseService()
      : auth = fb.auth(),
        databaseRef = fb.database().ref("test"),
        storageRef = fb.storage().ref("test") {
    this._postList = [];
    _setAuthListener();
    _setStorageListener();
  }

  // Sets the auth event listener.
  _setAuthListener() {
    // When the state of auth changes (user logs in/logs out).
    auth.onAuthStateChanged.listen((e) {
      this.user = e.user;

      _clearProfile();

      if (this.user != null) {
        _loadProfile(this.user);
      } else {}
    });
  }

  _onChildChanged(String key, Map val) {
    var temp = new SimplePost.fromMap(val);
    temp.key = key;
    _updateItem(temp);
  }

  _onChildAdded(String key, Map val) {
    var temp = new SimplePost.fromMap(val);
    temp.key = key;

    _postList.add(temp);
  }

  _onChildRemoved(String key, Map val) {
    _removeItem(key);
  }

  _setStorageListener() {
    // Setups listening on the child_changed event on the database ref
    databaseRef.onChildChanged.listen((e) {
      _onChildChanged(e.snapshot.key, e.snapshot.val());
    });
    // Setups listening on the child_added event on the database ref.
    databaseRef.onChildAdded.listen((e) {
      _onChildAdded(e.snapshot.key, e.snapshot.val());
    });
    // Setups listening on the child_removed event on the database ref.
    databaseRef.onChildRemoved.listen((e) {
      _onChildRemoved(e.snapshot.key, e.snapshot.val());
    });
  }

  // Logins with the Google auth provider.
  Future loginWithGoogle() async {
    var provider = new fb.GoogleAuthProvider();
    provider.setCustomParameters({'prompt': 'select_account'}); //force prompt to select account
    try {
      await auth.signInWithPopup(provider);
    } catch (e) {
      print("Error in sign in with google: $e");
    }
  }

  // Pushes a new item as a Map to database.
  postItem(SimplePost item) async {
    try {
      await databaseRef.push(SimplePost.toMap(item)).future;
    } catch (e) {
      print("Error in writing to database: $e");
    }
  }

  // Removes item with a key from database.
  delItem(String key) async {
    try {
      await databaseRef.child(key).remove();
    } catch (e) {
      print("Error in deleting $key: $e");
    }
  }

  // Update item in database
  updateItem(SimplePost item) async {
    try {
      await databaseRef.child(item.key).update(SimplePost.toMap(item));
    } catch (e) {
      print("Error in writing to database: $e");
    }
  }

  // Obtain a ref to post item by key
  SimplePost getItem(String key) {
    return _postList.firstWhere((post) => post.key == key);
  }

  addFile(var file, String filename) async {
    try {
      var snapshot = await storageRef.child(filename).put(file).future;
      return snapshot.downloadURL.toString();
    } catch (e) {
      print("Error in uploading to database: $e");
    }
  }

  // Removes item with a key from local list
  _removeItem(String key) {
    _postList.remove(_postList.firstWhere((post) => post.key == key));
  }

  _updateItem(SimplePost post) {
    int position = _postList.indexOf(_postList.firstWhere((e) => e.key == post.key));
    _postList[position] = post;
  }

  logOut() {
    auth.signOut();
    _postList = [];
  }

  _clearProfile() {}

  _loadProfile(var user) {}
}
