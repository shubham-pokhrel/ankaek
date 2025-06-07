import 'package:dio/dio.dart';
import '../../../../core/constants/app_constants.dart';
import '../models/post_model.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getPosts();
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final Dio dio;

  PostRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<PostModel>> getPosts() async {
    try {
      final response = await dio.get('${AppConstants.baseUrl}${AppConstants.postsEndpoint}');
      
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data;
        return jsonList.map((json) => PostModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load posts');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}