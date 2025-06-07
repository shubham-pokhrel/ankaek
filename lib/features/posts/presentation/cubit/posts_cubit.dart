import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/post.dart';
import '../../domain/usecases/get_posts.dart';
import '../../domain/usecases/save_post.dart';
import '../../domain/usecases/get_saved_posts.dart';
import '../../domain/usecases/delete_post.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  final GetPosts getPosts;
  final SavePost savePost;
  final GetSavedPosts getSavedPosts;
  final DeletePost deletePost;

  PostsCubit({
    required this.getPosts,
    required this.savePost,
    required this.getSavedPosts,
    required this.deletePost,
  }) : super(PostsInitial());

  Future<void> loadPosts() async {
    emit(PostsLoading());
    
    final result = await getPosts(const NoParams());
    result.fold(
      (failure) => emit(PostsError(failure.toString())),
      (posts) => emit(PostsLoaded(posts)),
    );
  }

  Future<void> loadSavedPosts() async {
    emit(SavedPostsLoading());
    
    final result = await getSavedPosts(const NoParams());
    result.fold(
      (failure) => emit(SavedPostsError(failure.toString())),
      (posts) => emit(SavedPostsLoaded(posts)),
    );
  }

  Future<void> savePostToLocal(Post post) async {
    final result = await savePost(post);
    result.fold(
      (failure) => emit(PostSaveError(failure.toString())),
      (_) {
        emit(PostSaved());
        loadSavedPosts(); // Refresh saved posts
      },
    );
  }

  Future<void> deletePostFromLocal(int postId) async {
    final result = await deletePost(postId);
    result.fold(
      (failure) => emit(PostDeleteError(failure.toString())),
      (_) {
        emit(PostDeleted());
        loadSavedPosts(); // Refresh saved posts
      },
    );
  }
}