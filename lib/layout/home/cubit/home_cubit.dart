import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/home/cubit/home_states.dart';
import 'package:social_app/models/comments_model/comments_model.dart';
import 'package:social_app/models/post_model/post_model.dart';
import 'package:social_app/models/user_model/user_model.dart';
import 'package:social_app/modules/chats/chats_screen.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/modules/new_post/new_post_screen.dart';
import 'package:social_app/modules/settings/settings_screen.dart';
import 'package:social_app/modules/users/users_screen.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  UserModel? model;

  void getUserData() {
    emit(HomeGetUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(CacheHelper.getData(key: 'uId'))
        .get()
        .then((value) {
      model = UserModel.fromJson(value.data());
      print(model?.name);
      emit(HomeGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(HomeGetUserErrorState(error.toString()));
    });
  }

  List<BottomNavigationBarItem> navList = [
    BottomNavigationBarItem(
      icon: Icon(
        IconBroken.Home,
      ),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        IconBroken.Chat,
      ),
      label: 'Chats',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        IconBroken.Paper_Upload,
      ),
      label: 'Post',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        IconBroken.Location,
      ),
      label: 'Users',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        IconBroken.Setting,
      ),
      label: 'Settings',
    ),
  ];

  int currentIndex = 0;
  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  List<String> titles = [
    'Home',
    'Chats',
    '',
    'Users',
    'Settings',
  ];

  void changeBottomNav(int index) {
    if (index == 2) {
      emit(HomeAddNewPostState());
    } else if(index==1) {
      currentIndex = index;
      getUsers();
      emit(HomeChangeBottomNavState());

    }
    else {
      currentIndex = index;
      emit(HomeChangeBottomNavState());
    }
  }

  File? profileImage = null;

  Future pickProfileImage() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage != null) {
      profileImage = File(returnedImage.path);
      emit(HomePickProfilePhotoSuccessState());
      print(profileImage);
    } else {
      print('saddddddddd');
    }
    emit(HomePickProfilePhotoErrorState());
  }

  File? coverImage = null;

  Future pickCoverImage() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage != null) {
      coverImage = File(returnedImage.path);
      emit(HomePickCoverPhotoSuccessState());
      print(coverImage);
    } else {
      print('sad  for cover');
      emit(HomePickCoverPhotoErrorState());
    }
  }

  // String? profileImageUrl;

  Future<void> uploadProfileImage({
    required String? name,
    required String? phone,
    required String? bio,
  }) async {
    emit(HomeUpdateUserLoadingState());
    if (profileImage != null) {
      FirebaseStorage.instance
          .ref()
          .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
          .putFile(profileImage!)
          .then((value) {
        print(value);
        value.ref.getDownloadURL().then((value) {
          // profileImageUrl = value;
          updateUser(name: name, phone: phone, bio: bio, profile: value);
          profileImage = null;
        }).catchError((error) {
          emit(HomeUploadProfilePhotoErrorState());
        });
      }).catchError((error) {
        emit(HomeUploadProfilePhotoErrorState());
      });
    }
  }

  // String? coverImageUrl;

  Future<void> uploadCoverImage({
    required String? name,
    required String? phone,
    required String? bio,
  }) async {
    {
      emit(HomeUpdateUserLoadingState());
      if (coverImage != null) {
        await FirebaseStorage.instance
            .ref()
            .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
            .putFile(coverImage!)
            .then((value) {
          print(value);
          value.ref.getDownloadURL().then((value) {
            // coverImageUrl = value;
            updateUser(name: name, phone: phone, bio: bio, cover: value);
            coverImage = null;
          }).catchError((error) {
            emit(HomeUploadCoverPhotoErrorState());
          });
        }).catchError((error) {
          emit(HomeUploadCoverPhotoErrorState());
        });
      }
    }
  }

  void updateUser({
    required String? name,
    required String? phone,
    required String? bio,
    String? cover,
    String? profile,
  }) {
    emit(HomeUpdateUserLoadingState());
    UserModel model2 = UserModel(
      name: name,
      phone: phone,
      bio: bio,
      image: profile ?? model?.image,
      coverImage: cover ?? model?.coverImage,
      password: model!.password,
      isEmailVerified: model?.isEmailVerified,
      uId: model?.uId,
      email: model?.email,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(model?.uId)
        .update(model2.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(HomeUpdateUserErrorState());
      print(error);
    });
  }

  File? postImage = null;

  Future pickPostImage() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage != null) {
      postImage = File(returnedImage.path);
      emit(PickPostPhotoSuccessState());
      print(postImage);
    } else {
      print('sad  for post');
      emit(PickPostPhotoErrorState());
    }
  }

  void deletePostImage() {
    postImage = null;
    emit(DeletePostSuccessState());
  }

  void uploadPostImage({
    required String? text,
    required String? dateTime,
  }) {
    {
      emit(CreatePostLoadingState());
      FirebaseStorage.instance
          .ref()
          .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
          .putFile(postImage!)
          .then((value) {
        print(value);
        value.ref.getDownloadURL().then((value) {
          postImage = null;
          createPost(text: text, dateTime: dateTime, postImage: value);
        }).catchError((error) {
          emit(CreatePostErrorState());
        });
      }).catchError((error) {
        emit(CreatePostErrorState());
      });
    }
  }

  void createPost({
    required String? text,
    required String? dateTime,
    String? postImage,
  }) {
    emit(CreatePostLoadingState());
    PostModel model2 = PostModel(
      name: model?.name,
      image: model?.image,
      uId: model?.uId,
      dateTime: dateTime,
      postImage: postImage ?? '',
      text: text,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model2.toMap())
        .then((value) {
      emit(CreatePostSuccessState());
    }).catchError((error) {
      emit(CreatePostErrorState());
      print(error);
    });
  }

  List<PostModel> posts = [];

  List<int> likes = [];
  List<int> comments = [];
  List<String> postId = [];
  int indexForLoopinggg = 0;
  int indexForLoopingComments = 0;
  int i = 0;

  void getPosts() {
    emit(GetPostsLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);

          element.reference.collection('comments').get().then((value) {
            // value.docs.forEach((element) {
            //   commentsModel.add(CommentsModel.fromJson(element.data()));
            //
            // });

            comments.add(value.docs.length);
            print(i);
            posts.add(PostModel.fromJson(element.data()));
            posts[i].postId = element.id;
            for (int index = 0; index < value.docs.length; index++) {
              print(value.docs[index]);
              print('we entered the post with the comment');
              print(value.docs[index].data());
              print(posts[i].postId);
              posts[i]
                  .commentsModel
                  .add(CommentsModel.fromJson(value.docs[index].data()));
              // [index]=CommentsModel.fromJson(value.docs[index].data())
              print('Index: $index'); // Print the index
            }

            i++;
            emit(LikeAndCommentPostsSuccessState());
          }).catchError((error) {
            print('the error we got is $error');
            emit(LikeAndCommentPostsErrorState(error));
          });
        }).catchError((error) {
          print('the error we got is $error');
        });
      });
      print('posts done');

      indexForLoopingComments = 0;
      indexForLoopinggg = 0;
      emit(GetPostsSuccessState());
    }).catchError((error) {
      print('the error we got is $error');

      indexForLoopingComments = 0;
      indexForLoopinggg = 0;
      emit(GetPostsErrorState(error.toString()));
    });
  }

  void likePost(String postId) {
    emit(LikeAndCommentPostsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(model?.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(LikeAndCommentPostsSuccessState());
    }).catchError((error) {
      emit(LikeAndCommentPostsErrorState(error.toString()));
    });
  }

  void addComment(CommentsModel model,String postId) {
    emit(AddCommentLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add(model.toMap())
        .then((value) {
          // getPosts();
      emit(AddCommentSuccessState());

    }).catchError((error) {
      print(error);
      emit(AddCommentErrorState());

    });
  }

  List<UserModel> users=[];

  void getUsers(){
    if(users.length==0) {
      emit(GetAllUsersLoadingState());

FirebaseFirestore.instance.collection('users').get().then((value) {
  value.docs.forEach((element) {
    if(element.data()['uId']!=model?.uId)
    users.add(UserModel.fromJson(element.data(),),);
  });
  emit(GetAllUsersSuccessState());

}).catchError((error){
  print(error);
  emit(GetAllUsersErrorState());

});}
  }
}
