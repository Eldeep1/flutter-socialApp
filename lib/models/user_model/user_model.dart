
class UserModel{
  String? name;
  String? uId;
  String? phone;
  String? email;
  String? image;
  String? bio;
  String? password;
  String? coverImage;
  bool? isEmailVerified;

  UserModel({
     this.email,
     this.phone,
     this.name,
     this.uId,
    this.bio,
    this.password,
     this.image,
     this.coverImage,
     this.isEmailVerified,
});

  UserModel.fromJson(Map<String,dynamic>? json){
    email=json?['email'];
    name=json?['name'];
    phone=json?['phone'];
    uId=json?['uId'];
    isEmailVerified=json?['isEmailVerified'];
    image=json?['image'];
    bio=json?['bio'];
    password=json?['password'];
    coverImage=json?['coverImage'];
  }

  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'phone':phone,
      'email':email,
      'uId':uId,
      'isEmailVerified':isEmailVerified,
      'image':image,
      'bio':bio,
      'password':password,
      'coverImage':coverImage,
    };
  }
}