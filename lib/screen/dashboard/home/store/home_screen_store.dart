import 'dart:convert';
import 'dart:developer';

import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:manch/models/post_response.dart';
import 'package:manch/screen/dashboard/profile/store/profile_screen_store.dart';

part 'home_screen_store.g.dart';

class HomeScreenStore = _HomeScreenStore with _$HomeScreenStore;

abstract class _HomeScreenStore with Store {
  final ProfileScreenStore profileStore;

  _HomeScreenStore({
    required this.profileStore,
  });

  final GlobalKey<FormState> postFormKey = GlobalKey();

  final TextEditingController postController = TextEditingController();

  @observable
  ObservableList<PostDatum> postList = ObservableList();

  @observable
  String? errorMessage;

  Future<void> sharePost() async {
    if (!postFormKey.currentState!.validate()) return;

    try {
      log('userProfile ${profileStore.userProfile?.name}');
      final response = await Supabase.instance.client.from('user_post').insert(
        {
          'post': postController.text.trim(),
          'user_id': Supabase.instance.client.auth.currentUser?.id,
          'user_meta': JsonMapper.toJson(profileStore.userProfile),
        },
      );

      if (response.error != null) {
        errorMessage = response.error?.message ?? 'Something went wrong!';
      } else {
        postController.clear();
        fetchPosts();
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> fetchPosts() async {
    try {
      final response =
          await Supabase.instance.client.from('user_post').select();

      final encodedData = json.encode(response);
      final mappedJson = JsonMapper.deserialize<List<dynamic>>(encodedData);
      log('response.data: $encodedData');
      postList.clear();
      mappedJson?.forEach((element) {
        postList.add(JsonMapper.deserialize<PostDatum>(element)!);
      });
    } catch (e, st) {
      if (e is PostgrestException) {
        log('Error: ${e.message}');
      }

      log(e.toString(), stackTrace: st);
    }
  }
}
