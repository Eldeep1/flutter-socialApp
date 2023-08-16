class MessageModel{
  String? dateTime;
  String? text;
  String? senderId;
  String? receiverId;
  MessageModel({
    this.senderId,
    this.text,
    this.dateTime,
    this.receiverId
  });
  MessageModel.fromJson(Map<String,dynamic> json){
    dateTime=json['dateTime'];
    text=json['text'];
    senderId=json['senderId'];
    receiverId=json['receiverId'];
  }
  Map<String,dynamic> toMap(){
  return{
    'text':text,
    'dateTime':dateTime,
    'senderId':senderId,
    'receiverId':receiverId,
  };
  }
}