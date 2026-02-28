class ProjectModel {
  final int id;
  final String title;
  final List<String> tags;
  final List<String> description;
  final String image;
  final String? pubDev;
  final String? github;
  ProjectModel({
    required this.id,
    required this.title,
    required this.tags,
    required this.description,
    required this.image,
    this.pubDev,
    this.github,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'] as int,
      title: json['title'] as String,
      tags: List<String>.from(json['tags']),
      description: List<String>.from(json['description']),
      image: json['image'] as String,
      pubDev: json['pubdev'] as String? ?? '',
      github: json['github'] as String? ?? '',
    );
  }
}
