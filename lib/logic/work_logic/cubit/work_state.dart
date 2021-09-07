part of 'work_cubit.dart';

@immutable
abstract class WorkState {}

class WorkInitial extends WorkState {}

class GetCurrentUserLoading extends WorkState {}

class GetCurrentUserSuccess extends WorkState {}

class GetCurrentUserFailed extends WorkState {}

class GetTasksFailed extends WorkState {}

class GetTasksLoading extends WorkState {}

class GetTasksSuccess extends WorkState {}

class ChangingCheck extends WorkState {}

class GetImageSuccess extends WorkState {}

class GetImageFailed extends WorkState {}

class UpdateProfileSuccess extends WorkState {}

class UpdateProfileFailed extends WorkState {}

class GetUsersLoading extends WorkState {}

class GetUsersSuccess extends WorkState {}

class GetUsersFailed extends WorkState {}

class UploadTaskLoading extends WorkState {}

class UploadTaskSuccess extends WorkState {}

class UploadTaskFailed extends WorkState {}

class DeleteTaskLoading extends WorkState {}

class DeleteTaskSuccess extends WorkState {}

class DeleteTaskFailed extends WorkState {}

class UpdateDoneStateSuccess extends WorkState {}

class UpdateDoneStateFailed extends WorkState {}

class ChangeThemeMode extends WorkState {}

class AddCommentLoading extends WorkState {}

class AddCommentSuccess extends WorkState {}

class AddCommentFailed extends WorkState {}

class GetComments extends WorkState {}
