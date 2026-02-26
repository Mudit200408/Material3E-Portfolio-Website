import 'package:flutter/foundation.dart';

import 'package:portfolio_web/models/project_model.dart';
import 'package:portfolio_web/models/skills_model.dart';
import 'package:portfolio_web/models/experience_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseServices {
  final SupabaseClient _client = Supabase.instance.client;

  // Static cache to store skills data in memory
  static List<SkillsModel>? _cachedSkills;
  // Static cache to store experience data in memory
  static List<ExperienceModel>? _cachedExperience;
  // Static cache to store project data in memory
  static List<ProjectModel>? _cachedProjects;

  Future<List<SkillsModel>> getSkills({bool forceRefresh = false}) async {
    // Return cached data if available and refresh is not forced
    if (!forceRefresh && _cachedSkills != null) {
      if (kDebugMode) debugPrint('Returning cached skills');
      return _cachedSkills!;
    }

    try {
      if (kDebugMode) debugPrint('Fetching skills from Supabase');
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
      if (kDebugMode) debugPrint('Error fetching skills: $e');
      return [];
    }
  }

  Future<List<ExperienceModel>> getExperience({
    bool forceRefresh = false,
  }) async {
    // Return cached data if available and refresh is not forced
    if (!forceRefresh && _cachedExperience != null) {
      if (kDebugMode) debugPrint('Returning cached experience');
      return _cachedExperience!;
    }

    try {
      if (kDebugMode) debugPrint('Fetching experience from Supabase');
      final response = await _client
          .from('experience')
          .select()
          .order('created_at', ascending: false);

      final experience = (response as List).map((item) {
        try {
          return ExperienceModel.fromJson(item);
        } catch (e) {
          if (kDebugMode) debugPrint('Error parsing item: $item, Error: $e');
          rethrow;
        }
      }).toList();

      // Update cache
      _cachedExperience = experience;

      return experience;
    } catch (e) {
      if (kDebugMode) debugPrint('Error fetching experience: $e');
      // Rethrow to let the UI handle the error state
      throw Exception('Failed to fetch experience: $e');
    }
  }

  Future<List<ProjectModel>> getProjects({bool forceRefresh = false}) async {
    // Return cached data if available and refresh is not forced
    if (!forceRefresh && _cachedProjects != null) {
      if (kDebugMode) debugPrint('Returning cached Projects');
      return _cachedProjects!;
    }

    try {
      if (kDebugMode) debugPrint('Fetching projects from Supabase');
      final response = await _client
          .from('project')
          .select()
          .order('created_at', ascending: false);

      final projects = (response as List).map((item) {
        try {
          return ProjectModel.fromJson(item);
        } catch (e) {
          if (kDebugMode) debugPrint('Error parsing items: $item, Error: $e');
          rethrow;
        }
      }).toList();

      //Update cache
      _cachedProjects = projects;

      return projects;
    } catch (e) {
      if (kDebugMode) debugPrint('Error fetching projects: $e');
      // Rethrow to let the UI handle the error state
      throw Exception('Failed to fetch projects: $e');
    }
  }
}
