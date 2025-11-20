import 'package:flutter/material.dart';
import 'package:portfolio_web/models/skills_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseServices {
  final SupabaseClient _client = Supabase.instance.client;

  // Static cache to store skills data in memory
  static List<SkillsModel>? _cachedSkills;

  Future<List<SkillsModel>> getSkills({bool forceRefresh = false}) async {
    // Return cached data if available and refresh is not forced
    if (!forceRefresh && _cachedSkills != null) {
      debugPrint('Returning cached skills');
      return _cachedSkills!;
    }

    try {
      debugPrint('Fetching skills from Supabase');
      final response = await _client
          .from('skills')
          .select('skill_name, order')
          .order('order', ascending: true);

      final skills = (response as List)
          .map((skill) => SkillsModel.fromJson(skill))
          .toList();

      // Update cache
      _cachedSkills = skills;

      return skills;
    } catch (e) {
      debugPrint('Error fetching skills: $e');
      return [];
    }
  }
}
