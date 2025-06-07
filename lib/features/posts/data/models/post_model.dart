import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/post.dart';

part 'post_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class PostModel extends Post {
  @HiveField(0)
  @override
  final int id;

  @HiveField(1)
  @override
  final int userId;

  @HiveField(2)
  @override
  final String title;

  @HiveField(3)
  @override
  final String body;

  const PostModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  }) : super(
          id: id,
          userId: userId,
          title: title,
          body: body,
        );

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelToJson(this);

  factory PostModel.fromEntity(Post post) {
    return PostModel(
      id: post.id,
      userId: post.userId,
      title: post.title,
      body: post.body,
    );
  }
}