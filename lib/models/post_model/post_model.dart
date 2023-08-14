
import 'package:social_app/models/comments_model/comments_model.dart';

class PostModel{
  String? name;
  String? uId;
  String? postImage;
  String? image;
  String? dateTime;
  String? text;
  String? postId;
  int likesNumbers=0;
  int commentNumbers=0;
  List<CommentsModel> commentsModel = [];


  PostModel({
    this.name,
    this.uId,
    this.postImage,
    this.text,
    this.dateTime,
    this.image,
  });

  PostModel.fromJson(Map<String,dynamic>? json){
    name=json?['name'];
    uId=json?['uId'];
    postImage=json?['postImage'];
    image=json?['image'];
    text=json?['text'];
    dateTime=json?['dateTime'];
  }

  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'uId':uId,
      'postImage':postImage,
      'image':image,
      'text':text,
      'dateTime':dateTime,
    };
  }

  void addToComments(json,indexForLoopingComments){
    commentsModel[indexForLoopingComments]=CommentsModel.fromJson(json);
  }
}