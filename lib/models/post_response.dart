import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class PostDatum {
  @JsonProperty(name: 'id')
  int id;
  @JsonProperty(name: 'inserted_at')
  DateTime insertedAt;
  @JsonProperty(name: 'updated_at')
  DateTime updatedAt;
  @JsonProperty(name: 'post')
  String post;
  @JsonProperty(name: 'user_id')
  String userId;
  @JsonProperty(name: 'user_meta')
  Map<String, dynamic>? userMeta;

  PostDatum(
    this.id,
    this.insertedAt,
    this.updatedAt,
    this.post,
    this.userId,
    this.userMeta,
  );
}
