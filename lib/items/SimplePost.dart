library pamescan.item;

const String jsonTagText = "text";
const String jsonTagTitle = "title";
const String jsonTagImgUrl = "img_url";

class SimplePost {
  String key;
  String text;
  String title;
  String imageUrl;

  SimplePost(this.text, [this.title, this.imageUrl, this.key]);

  static Map toMap(SimplePost item) {
    Map jsonMap = {
      jsonTagText: item.text,
      jsonTagTitle: item.title,
      jsonTagImgUrl: item.imageUrl
    };
    return jsonMap;
  }
}
