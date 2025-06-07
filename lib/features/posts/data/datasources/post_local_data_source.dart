import 'package:hive/hive.dart';
import '../../../../core/constants/app_constants.dart';
import '../models/post_model.dart';

abstract class PostLocalDataSource {
  Future<void> savePost(PostModel post);
  Future<List<PostModel>> getSavedPosts();
  Future<void> deletePost(int postId);
}

class PostLocalDataSourceImpl implements PostLocalDataSource {
  final Box<PostModel> box;

  PostLocalDataSourceImpl({required this.box});

  @override
  Future<void> savePost(PostModel post) async {
    await box.put(post.id, post);
  }

  @override
  Future<List<PostModel>> getSavedPosts() async {
    return box.values.toList();
  }

  @override
  Future<void> deletePost(int postId) async {
    await box.delete(postId);
  }
}