abstract class HomeStates{}

class HomeInitialState extends HomeStates{}

class HomeGetUserLoadingState extends HomeStates{}

class HomeGetUserSuccessState extends HomeStates{}

class HomeGetUserErrorState extends HomeStates{
  final String error;

  HomeGetUserErrorState(this.error);
}

class HomeChangeBottomNavState extends HomeStates{}

class HomeAddNewPostState extends HomeStates{}

class HomePickProfilePhotoSuccessState extends HomeStates{}

class HomePickCoverPhotoSuccessState extends HomeStates{}

class HomePickProfilePhotoErrorState extends HomeStates{}

class HomePickCoverPhotoErrorState extends HomeStates{}

class HomeUploadProfilePhotoSuccessState extends HomeStates{}

class HomeUploadProfilePhotoErrorState extends HomeStates{

}
class HomeUploadCoverPhotoSuccessState extends HomeStates{}

class HomeUploadCoverPhotoErrorState extends HomeStates{}

class HomeUpdateUserSuccessState extends HomeStates{}

class HomeUpdateUserLoadingState extends HomeStates{}

class HomeUpdateUserErrorState extends HomeStates{}

class HomeShowLinearProgressIndicatorState extends HomeStates{}



class CreatePostLoadingState extends HomeStates{}

class CreatePostErrorState extends HomeStates{}

class CreatePostSuccessState extends HomeStates{}

class DeletePostSuccessState extends HomeStates{}

class PickPostPhotoSuccessState extends HomeStates{}

class PickPostPhotoErrorState extends HomeStates{}



class GetPostsLoadingState extends HomeStates{}

class GetPostsSuccessState extends HomeStates{}

class GetPostsErrorState extends HomeStates{
  final eror;

  GetPostsErrorState(this.eror);
}


class LikeAndCommentPostsLoadingState extends HomeStates{}

class LikeAndCommentPostsSuccessState extends HomeStates{}

class LikeAndCommentPostsErrorState extends HomeStates{
  final error;

  LikeAndCommentPostsErrorState(this.error);
}

class AddCommentLoadingState extends HomeStates{}
class AddCommentSuccessState extends HomeStates{}
class AddCommentErrorState extends HomeStates{}

class GetAllUsersLoadingState extends HomeStates{}
class GetAllUsersSuccessState extends HomeStates{}
class GetAllUsersErrorState extends HomeStates{}

class SendMessageSuccessState extends HomeStates{}
class SendMessageErrorState extends HomeStates{}

class GetMessageSuccessState extends HomeStates{}
class GetMessageErrorState extends HomeStates{}