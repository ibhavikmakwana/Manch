
import 'package:manch/data/models/user_profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserProfileRepository {
  Future<UserProfile> getProfile() async {
    try {
      final userId = Supabase.instance.client.auth.currentUser?.id;
      final response = await Supabase.instance.client
          .from('profiles')
          .select()
          .eq('id', '$userId')
          .single();
      UserProfile userProfile = UserProfile.fromJson(response);
      return userProfile;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserProfile> updateProfile(UserProfile userProfile) async {
    try {
      final userId = Supabase.instance.client.auth.currentUser?.id;
      final response = await Supabase.instance.client
          .from('profiles')
          .update(userProfile.toJson())
          .eq('id', '$userId')
          .select();
      return UserProfile.fromJson(response.first);
    } catch (e) {
      rethrow;
    }
  }
}
