class ProjectModel {
  final String title;
  final String description1;
  final String? description2;
  final String? description3;
  final List<String> languageTags;
  final String imagePath;
  final String githubLink;
  final String? liveDemoLink;

  ProjectModel(
    this.description3,
    this.languageTags,
    this.githubLink,
    this.liveDemoLink, {
    required this.imagePath,
    required this.title,
    required this.description1,
    this.description2,
  });
}
