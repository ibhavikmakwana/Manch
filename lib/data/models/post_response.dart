import 'package:json_annotation/json_annotation.dart';

part 'post_response.g.dart';

@JsonSerializable()
class PostDatum {
  final int id;
  @JsonKey(name: 'inserted_at')
  final DateTime insertedAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  final String post;
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'user_meta')
  final Map<String, dynamic>? userMeta;

  const PostDatum({
    required this.id,
    required this.insertedAt,
    required this.updatedAt,
    required this.post,
    required this.userId,
    this.userMeta,
  });

  PostDatum copyWith({
    int? id,
    DateTime? insertedAt,
    DateTime? updatedAt,
    String? post,
    String? userId,
    Map<String, dynamic>? userMeta,
  }) {
    return PostDatum(
      id: id ?? this.id,
      insertedAt: insertedAt ?? this.insertedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      post: post ?? this.post,
      userId: userId ?? this.userId,
      userMeta: userMeta ?? this.userMeta,
    );
  }

  factory PostDatum.fromJson(Map<String, dynamic> json) =>
      _$PostDatumFromJson(json);

  Map<String, dynamic> toJson() => _$PostDatumToJson(this);
}
