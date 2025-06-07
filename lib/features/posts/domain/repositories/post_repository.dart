import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/post.dart';

abstract class PostRepository {
  Future<Either<Failure, List<Post>>> getPosts();
  Future<Either<Failure, void>> savePost(Post post);
  Future<Either<Failure, List<Post>>> getSavedPosts();
  Future<Either<Failure, void>> deletePost(int postId);
}