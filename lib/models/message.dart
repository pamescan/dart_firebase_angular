library pamescan.models;

const String jsonTagName = "name";
const String jsonTagText = "text";
const String jsonTagPhotoUrl = "photo_url";
const String jsonTagImgUrl = "img_url";


class Message{
  final String name;
  final String text;
  String photoUrl;
  String imageUrl;

  Message (this.name,[this.text,this.photoUrl,this.imageUrl]){
    this.photoUrl = photoUrl ?? "https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg";
  }

  Message.fromMap(Map map):
      this(map[jsonTagName],map[jsonTagText],map[jsonTagPhotoUrl],map[jsonTagImgUrl]);

  Map toMap()=>{
   jsonTagName : this.name,
   jsonTagText : this.text,
   jsonTagPhotoUrl : this.photoUrl,
   jsonTagImgUrl  :this.imageUrl,
  };

}