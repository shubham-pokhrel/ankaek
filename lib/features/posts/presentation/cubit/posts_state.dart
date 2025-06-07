part of 'posts_cubit.dart';

abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

class PostsInitial extends PostsState {}

class PostsLoading extends PostsState {}

class PostsLoaded extends PostsState {
  final List<Post> posts;

  const PostsLoaded(this.posts);

  @override
  List<Object> get props => [posts];
}

class PostsError extends PostsState {
  final String message;

  const PostsError(this.message);

  @override
  List<Object> get props => [message];
}

class SavedPostsLoading extends PostsState {}

class SavedPostsLoaded extends PostsState {
  final List<Post> posts;

  const SavedPostsLoaded(this.posts);

  @override
  List<Object> get props => [posts];
}

class SavedPostsError extends PostsState {
  final String message;

  const SavedPostsError(this.message);

  @override
  List<Object> get props => [message];
}

class PostSaved extends PostsState {}

class PostSaveError extends PostsState {
  final String message;

  const PostSaveError(this.message);

  @override
  List<Object> get props => [message];
}

class PostDeleted extends PostsState {}

class PostDeleteError extends PostsState {
  final String message;

  const PostDeleteError(this.message);

  @override
  List<Object> get props => [message];
}