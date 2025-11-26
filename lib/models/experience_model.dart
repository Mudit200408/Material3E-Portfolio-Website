class ExperienceModel {
  final int id;
  final String companyName;
  final String jobTitle;
  final String startDate;
  final String? endDate;
  final List<String> responsibilities;
  final String location;

  ExperienceModel({
    required this.id,
    required this.companyName,
    required this.jobTitle,
    required this.startDate,
    this.endDate,
    required this.responsibilities,
    required this.location,
  });

  factory ExperienceModel.fromJson(Map<String, dynamic> json) {
    return ExperienceModel(
      id: json['id'] as int,
      companyName: json['company_name'] as String,
      jobTitle: json['job_title'] as String,
      startDate: json['start_date'] as String,
      endDate: json['end_date'] as String?,
      responsibilities: List<String>.from(json['responsibilities'] ?? []),
      location: json['location'] as String? ?? 'Remote',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company_name': companyName,
      'job_title': jobTitle,
      'start_date': startDate,
      'end_date': endDate,
      'responsibilities': responsibilities,
      'location': location,
    };
  }
}
