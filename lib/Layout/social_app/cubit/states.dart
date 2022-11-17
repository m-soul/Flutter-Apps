abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

class SocialGetUserLoadingState extends SocialStates {}

class SocialBottomNavState extends SocialStates {}

class SocialGetUserSuccessState extends SocialStates {}

class SocialProfilePicturePickedSuccessState extends SocialStates {}

class SocialUploadProfilePictureSuccessState extends SocialStates {}

class SocialUploadProfilePictureLoadingState extends SocialStates {}

class SocialUploadCoverPictureLoadingState extends SocialStates {}

class SocialUploadProfilePictureErrorState extends SocialStates {}

class SocialUploadCoverPictureSuccessState extends SocialStates {}

class SocialUploadCoverPictureErrorState extends SocialStates {}

class SocialProfilePicturePickedErrorState extends SocialStates {}

class SocialCoverPicturePickedSuccessState extends SocialStates {}

class SocialCoverPicturePickedErrorState extends SocialStates {}

class SocialUserUpdateErrorState extends SocialStates {}

class SocialGetUserErrorState extends SocialStates {
  final String error;

  SocialGetUserErrorState(this.error);
}

//create post
class SocialCreatePostLoadingState extends SocialStates {}

class SocialCreatePostErrorState extends SocialStates {}

class SocialCreatePostSuccessState extends SocialStates {}

class SocialPostImagePickedSuccessState extends SocialStates {}

class SocialPostImagePickedErrorState extends SocialStates {}

class SocialRemovePostImageState extends SocialStates {}

// get posts

class SocialGetPostsSuccessState extends SocialStates {}

class SocialGetCommentsNumberSuccessState extends SocialStates {}

class SocialGetLikesNumberSuccessState extends SocialStates {}

class SocialGetPostsErrorState extends SocialStates {
  final String error;

  SocialGetPostsErrorState(this.error);
}

class SocialGetPostsLoadingState extends SocialStates {}

// like posts

class SocialLikePostSuccessState extends SocialStates {}

class SocialLikePostErrorState extends SocialStates {}

// commentPosts

class SocialCommentPostSuccessState extends SocialStates {}

class SocialCommentPostErrorState extends SocialStates {}

//get users

class SocialGetAllUsersLoadingState extends SocialStates {}

class SocialGetAllUsersSuccessState extends SocialStates {}

class SocialGetAllUsersErrorState extends SocialStates {
  final String error;

  SocialGetAllUsersErrorState(this.error);
}

// chat

class SocialSendMessageSuccessState extends SocialStates {}

class SocialSendMessageErrorState extends SocialStates {}

class SocialGetMessagesSuccessState extends SocialStates {}

// logout

class SocialLogOutSuccessState extends SocialStates {}
