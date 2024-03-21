import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:manch/data/models/post_response.dart';
import 'package:manch/data/repositories/post_repository.dart';
import 'package:mobx/mobx.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:manch/screen/dashboard/profile/store/profile_screen_store.dart';

part 'home_screen_store.g.dart';

class HomeScreenStore = _HomeScreenStore with _$HomeScreenStore;

abstract class _HomeScreenStore with Store {
  final ProfileScreenStore profileStore;

  _HomeScreenStore({
    required this.profileStore,
  });

  final PostRepository _repository = PostRepository();

  final GlobalKey<FormState> postFormKey = GlobalKey();

  final TextEditingController postController = TextEditingController();

  @observable
  ObservableList<PostDatum> postList = ObservableList();

  @observable
  String? errorMessage;

  Future<void> sharePost() async {
    if (!postFormKey.currentState!.validate()) return;

    try {
      final post = await _repository.sharePost(
        post: postController.text.trim(),
        userId: Supabase.instance.client.auth.currentUser?.id ?? '',
        userMeta: profileStore.userProfile?.toJson(),
      );
      postList.insert(0, post);
    } catch (e, st) {
      if (e is PostgrestException) {
        log('Error: ${e.message}');
      }

      log(e.toString(), stackTrace: st);
    }
  }

  Future<void> fetchPosts() async {
    try {
      final posts = await _repository.fetchPosts();
      postList = ObservableList.of(posts);
    } catch (e, st) {
      if (e is PostgrestException) {
        log('Error: ${e.message}');
      }

      log(e.toString(), stackTrace: st);
    }
  }
}
