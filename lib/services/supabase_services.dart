import 'package:flutter/material.dart';
import 'package:portfolio_web/models/skills_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseServices {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<SkillsModel>> getSkills() async {
    try {
      final response = await _client
          .from('skills')
          .select('skill_name, order')
          .order('order', ascending: true);

      return (response as List)
          .map((skill) => SkillsModel.fromJson(skill))
          .toList();
    } catch (e) {
      debugPrint('Error fetching skills: $e');
      return [];
    }
  }
}
