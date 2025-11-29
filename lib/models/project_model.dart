class ProjectModel {
  int id;
  String title;
  List<String> tags;
  List<String> description;
  String image;
  String? pubDev;
  String? github;
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
      pubDev: json['pubDev'] as String? ?? '',
      github: json['github'] as String? ?? '',
    );
  }
}
