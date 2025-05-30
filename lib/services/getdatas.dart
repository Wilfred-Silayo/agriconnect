import 'package:supabase_flutter/supabase_flutter.dart';

class GetAllDetails {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<String?> getPostDetails(String postId) async {
    try {
      final data = await supabase
          .from('Posts')
          .select('userrole')
          .eq('id', postId)
          .single();

      return data['userrole'] as String?;
    } catch (error) {
      print('Error retrieving post details: $error');
      return null;
    }
  }
}
