import 'dart:async';
import 'package:angular2/core.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:pamescan/services/service_simple_post.dart';
import 'package:pamescan/items/SimplePost.dart';

@Injectable()
class FirebaseService {

  //final SimplePostService sps;
  final fb.Auth auth;
  final fb.DatabaseReference databaseRef;
  final fb.StorageReference storageRef;

  fb.UserInfo user; //logged user info
  List<SimplePost> postList;


  bool get isUserLogged => user != null;

  FirebaseService()
      :
        auth = fb.auth(),
        databaseRef = fb.database().ref("test"),
        storageRef = fb.storage().ref("test") {
    this.postList = [];
    _setAuthListener();
    _setStorageListener();
  }

  // Sets the auth event listener.
  _setAuthListener() {
    // When the state of auth changes (user logs in/logs out).
    auth.onAuthStateChanged.listen((e) {
      this.user = e.user;
      _clearProfile();

      if (user != null) {
        _loadProfile(user);
      } else {

      }
    });
  }

  _setStorageListener() {
    //sps.setStorageListener(databaseRef);

    // Setups listening on the child_changed event on the database ref
    databaseRef.onChildChanged.listen((e) {
      // Snapshot of the data.
      fb.DataSnapshot data = e.snapshot;
      // Value of data from snapshot.
      var val = data.val();
      var item = new SimplePost(
          val[jsonTagText], val[jsonTagTitle], val[jsonTagImgUrl], data.key);
      _updateItem(item);
    });
    // Setups listening on the child_added event on the database ref.
    databaseRef.onChildAdded.listen((e) {
      // Snapshot of the data.
      fb.DataSnapshot data = e.snapshot;

      // Value of data from snapshot.
      var val = data.val();
      // Creates a new SimplePost item. It is possible to retrieve a key from data.
      var item = new SimplePost(
          val[jsonTagText], val[jsonTagTitle], val[jsonTagImgUrl], data.key);
      postList.add(item);
      //_showItem(item);
    });
    // Setups listening on the child_removed event on the database ref.
    databaseRef.onChildRemoved.listen((e) {
      fb.DataSnapshot data = e.snapshot;
      var val = data.val();

      // Removes also the image from storage.
      var imageUrl = val[jsonTagImgUrl];
      if (imageUrl != null) {
        //removeItemImage(imageUrl);
      }

      _removeItem(data.key);
      //_clearItem(data.key);
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
      await databaseRef
          .push(SimplePost.toMap(item))
          .future;
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
  updateItem(SimplePost item)async{
    try {
      await databaseRef.child(item.key)
          .update(SimplePost.toMap(item));
    } catch (e) {
      print("Error in writing to database: $e");
    }
  }

  SimplePost getItem(String key){
    return postList.firstWhere((post) => post.key == key);
  }

  // Removes item with a key from local list
  _removeItem(String key) {
    postList.remove(postList.firstWhere((post) => post.key == key));
  }

  _updateItem(SimplePost post) {
    int position = postList.indexOf(postList.firstWhere((e) => e.key == post.key));
    postList[position] = post;
  }

  logOut() {
    auth.signOut();
    postList = [];
  }

  _clearProfile() {

  }

  _loadProfile(var user) {

  }
}