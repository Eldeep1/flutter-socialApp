
class CommentsModel{
  String? name;
  String? image;
  String? dateTime;
  String? text;



  CommentsModel({
    this.name,
    this.text,
    this.dateTime,
    this.image,
  });

  CommentsModel.fromJson(Map<String,dynamic>? json){
    name=json?['name'];
    image=json?['image'];
    text=json?['text'];
    dateTime=json?['dateTime'];
  }

  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'image':image,
      'text':text,
      'dateTime':dateTime,
    };
  }
}