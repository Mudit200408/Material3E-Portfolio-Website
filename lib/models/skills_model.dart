class SkillsModel {
  final String skillName;
  final int order;

  SkillsModel({required this.skillName, required this.order});

  factory SkillsModel.fromJson(Map<String, dynamic> json) {
    return SkillsModel(
      skillName: json['skill_name'] as String,
      order: json['order'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {'skill_name': skillName, 'order': order};
  }
}
