library pamescan.item;

const String jsonTagKey = "key";
const String jsonTagText = "text";
const String jsonTagTitle = "title";
const String jsonTagImgUrl = "img_url";
const String jsonTagUserName = "user_name";
const String jsonTagUserKey = "user_key";

class SimplePost {

  String text;
  String title;
  String imageUrl;
  String userName;
  String userKey;
  String key;


  SimplePost(this.text,
             [this.title,
             this.imageUrl,
             this.userName,
             this.userKey,
             this.key]);

  SimplePost.fromMap(Map val) :this(

    val[jsonTagText],
    val[jsonTagTitle],
    val[jsonTagImgUrl],
    val[jsonTagUserName],
    val[jsonTagUserKey],
    val[jsonTagKey]
    );

  static Map toMap(SimplePost item) {
    Map jsonMap = {
      jsonTagKey: item.key,
      jsonTagText: item.text,
      jsonTagTitle: item.title,
      jsonTagImgUrl: item.imageUrl,
      jsonTagUserName: item.userName,
      jsonTagUserKey: item.userKey,
    };
    return jsonMap;
  }


}
