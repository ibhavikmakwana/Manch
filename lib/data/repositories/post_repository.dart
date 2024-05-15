
import 'package:manch/data/models/post_response.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PostRepository {
  Future<List<PostDatum>> fetchPosts() async {
    try {
      final response =
          await Supabase.instance.client.from('post').select();
      final postList = <PostDatum>[];
      response.forEach((element) {
        postList.add(PostDatum.fromJson(element));
      });
      return postList;
    } catch (e) {
      rethrow;
    }
  }

  Future<PostDatum> sharePost({
    required String post,
    required String userId,
    Map<String, dynamic>? userMeta,
  }) async {
    try {
      final response = await Supabase.instance.client.from('post').insert(
        {
          'post': post.trim(),
          'user_id': Supabase.instance.client.auth.currentUser?.id,
          'user_meta': userMeta,
        },
      ).select();
      return PostDatum.fromJson(response.first);
    } catch (e) {
      rethrow;
    }
  }
}
