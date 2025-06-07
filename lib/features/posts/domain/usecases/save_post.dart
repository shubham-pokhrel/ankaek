import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/post.dart';
import '../repositories/post_repository.dart';

class SavePost implements UseCase<void, Post> {
  final PostRepository repository;

  SavePost(this.repository);

  @override
  Future<Either<Failure, void>> call(Post post) async {
    return await repository.savePost(post);
  }
}